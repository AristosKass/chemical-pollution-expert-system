"""Run the real CLIPS engine against examples, model data, and edge cases."""
from pathlib import Path
import re
import unittest

import clips

ROOT = Path(__file__).resolve().parents[1]


class Console(clips.Router):
    """Supply deterministic terminal input and capture CLIPS output."""

    def __init__(self, data=""):
        super().__init__("test-console", 40)
        self.data = data.encode("utf-8")
        self.position = 0
        self.pushed = []
        self.output = []

    def query(self, name):
        return name in ("stdin", "stdout", "stderr", "stdwrn")

    def write(self, name, message):
        self.output.append(message)

    def read(self, name):
        if self.pushed:
            return self.pushed.pop()
        if self.position >= len(self.data):
            return -1
        character = self.data[self.position]
        self.position += 1
        return character

    def unread(self, name, character):
        self.pushed.append(character)
        return character


class PollutionTests(unittest.TestCase):
    def setUp(self):
        self.env = clips.Environment()
        self.console = Console()
        self.env.add_router(self.console)
        self.env.load(str(ROOT / "clips/pollution.clp"))
        self.env.reset()

    def evaluate(self, expression):
        return self.env.eval(expression)

    def names(self, expression):
        return {str(x) for x in self.evaluate(expression)}

    def run_input(self, data):
        self.console.data = data.encode("utf-8")
        self.env.run()
        output = "".join(self.console.output)
        self.assertNotIn("[EXPRNPSR", output)
        self.assertNotIn("[ARGACCES", output)
        self.assertNotIn("[PRCCODE", output)
        return output

    def test_model_counts_and_routes(self):
        self.assertEqual(len(list(self.env.instances())), 32)
        self.assertEqual(str(self.evaluate("(validate-knowledge)")), "TRUE")
        expected = {1: [1, 9, 12], 2: [2, 9, 12], 3: [3, 9, 12],
                    4: [4, 10, 12], 5: [5, 10, 12], 6: [6, 11, 13],
                    7: [7, 11, 13], 8: [8, 13]}
        for store, route in expected.items():
            with self.subTest(store=store):
                actual = self.evaluate(f"(path-to-station (send [store_{store}] get-connectedManhole))")
                self.assertEqual([str(x) for x in actual],
                                 [f"manhole_{x}" for x in route] + ["monitoring_station"])

    def test_example_1_radioactive_metal(self):
        out = self.run_input((ROOT / "examples/01-radioactive-metal.txt").read_text())
        self.assertIn("[rubidium_hydroxide]", out)
        self.assertIn("H phgh ths molynshs einai h apothiki [store_3]", out)
        self.assertNotIn("Yparxei molynsh sto freatio", out)

    def test_example_2_petrol(self):
        out = self.run_input((ROOT / "examples/02-petrol.txt").read_text())
        questions = re.findall(r"Yparxei molynsh sto freatio (\w+)", out)
        self.assertEqual(questions, ["manhole_10", "manhole_5"])
        self.assertIn("[petrol]", out)
        self.assertIn("Pithanoi kindynoi: explosive", out)
        self.assertIn("H phgh ths molynshs einai h apothiki [store_4]", out)

    def test_example_3_strong_acids(self):
        out = self.run_input((ROOT / "examples/03-strong-acids.txt").read_text())
        self.assertEqual(re.findall(r"Yparxei molynsh sto freatio (\w+)", out), ["manhole_13"])
        self.assertIn("[sulphuric_acid]", out)
        self.assertIn("[hydrochloric_acid]", out)
        self.assertIn("burns_skin", out)
        self.assertIn("asphyxiation", out)
        self.assertIn("H phgh ths molynshs einai h apothiki [store_7]", out)

    def test_aluminium_is_nonradioactive_metal(self):
        out = self.run_input("spectroscopy radioactivity\nmetal\nno\n")
        self.assertIn("[aluminium_hydroxide]", out)
        self.assertIn("H phgh ths molynshs einai h apothiki [store_6]", out)
        self.assertNotIn("[rubidium_hydroxide]", out)

    def test_identification_of_each_chemical(self):
        observations = {
            "sulphuric_acid": "2 soluble (create$ sulphur) none none equal_to_water no",
            "hydrochloric_acid": "2 soluble (create$ none) none choking equal_to_water no",
            "acetic_acid": "4 soluble (create$ none) none vinegar equal_to_water no",
            "carbonic_acid": "4 soluble (create$ carbon) none none equal_to_water no",
            "sodium_hydroxide": "12 soluble (create$ sodium) none none equal_to_water no",
            "chromogen_23": "9 soluble (create$ none) red none lighter_than_water no",
            "aluminium_hydroxide": "9 soluble (create$ metal) white none heavier_than_water no",
            "rubidium_hydroxide": "9 soluble (create$ metal) none none heavier_than_water yes",
            "petrol": "7 insoluble (create$ carbon) none none lighter_than_water no",
            "transformer_oil": "7 insoluble (create$ carbon) none none equal_to_water no",
        }
        for chemical, measurements in observations.items():
            with self.subTest(chemical=chemical):
                matching = self.names(f"(find-all-instances ((?c Chemical)) (chemical-matches ?c {measurements}))")
                self.assertEqual(matching, {chemical})

    def test_ph_boundaries(self):
        cases = [(0, "acid", "strong"), (2.9999, "acid", "strong"),
                 (3, "acid", "weak"), (5.9999, "acid", "weak"),
                 (6, "oil", "none"), (7.9999, "oil", "none"),
                 (8, "base", "weak"), (10.9999, "base", "weak"),
                 (11, "base", "strong"), (14, "base", "strong")]
        for value, category, strength in cases:
            with self.subTest(value=value):
                self.assertEqual(str(self.evaluate(f"(ph->category {value})")), category)
                self.assertEqual(str(self.evaluate(f"(ph->strength {value} {category})")), strength)

    def test_gravity_boundaries(self):
        for value, expected in [(0.9, "lighter_than_water"), (0.99999, "lighter_than_water"),
                                (1, "equal_to_water"), (1.00001, "heavier_than_water"),
                                (1.1, "heavier_than_water")]:
            with self.subTest(value=value):
                self.assertEqual(str(self.evaluate(f"(sg->hint {value})")), expected)

    def test_spectrum_requires_all_reported_elements(self):
        candidates = self.names("(find-all-instances ((?c Chemical)) (chemical-matches ?c unknown unknown (create$ carbon metal) unknown unknown unknown unknown))")
        self.assertEqual(candidates, set())
        self.evaluate("(send [petrol] put-spectroscopy carbon metal)")
        self.assertEqual(self.names("(find-all-instances ((?c Chemical)) (chemical-matches ?c unknown unknown (create$ carbon metal) unknown unknown unknown unknown))"), {"petrol"})
        self.assertEqual(str(self.evaluate("(chemical-matches [petrol] unknown unknown (create$ carbon) unknown unknown unknown unknown)")), "TRUE")

    def test_contradictory_measurements_have_no_match(self):
        out = self.run_input("pH solubility\n2\ninsoluble\n")
        self.assertIn("Den vrethike xhmiko pou na ejhgei oles tis metriseis", out)
        self.assertNotIn("H phgh", out)

    def test_invalid_measurement_name_is_retried(self):
        out = self.run_input("pH typo\npH\n2\nyes\n")
        self.assertIn("Mh egkyrh metrisi", out)
        self.assertIn("[store_7]", out)

    def test_out_of_range_and_non_number_are_retried(self):
        out = self.run_input("pH\nword\n15\n2\nyes\n")
        self.assertEqual(out.count("Mh egkyrh timh. Dose arithmo"), 2)
        self.assertIn("[store_7]", out)

    def test_invalid_choice_is_retried(self):
        out = self.run_input("solubility specific_gravity\nwrong\ninsoluble\n0.95\nyes\nno\n")
        self.assertIn("Mh egkyrh timh. Epilexe apo", out)
        self.assertIn("[store_4]", out)

    def test_none_with_element_is_rejected(self):
        out = self.run_input("spectrometry radioactivity\nnone metal\nmetal\nyes\n")
        self.assertIn("To none den syndyazetai me stoixeia", out)
        self.assertIn("[store_3]", out)

    def test_eof_at_each_kind_of_prompt(self):
        inputs = ["", "\n", "pH\n", "solubility\n", "spectrometry\n",
                  "specific_gravity\n", "radioactivity\n", "pH\n2\n",
                  "spectrometry\ninvalid\n", "pH\nword\n"]
        for data in inputs:
            with self.subTest(data=data):
                self.setUp()
                out = self.run_input(data)
                self.assertEqual(out.count("Telos eisodou"), 1)
                self.assertNotIn("H phgh ths molynshs einai", out)

    def test_cycle_is_detected_before_input(self):
        self.evaluate("(send [manhole_12] put-downstream [manhole_9])")
        self.assertEqual(tuple(self.evaluate("(path-to-station [manhole_1])")), ())
        out = self.run_input("")
        self.assertIn("Mh egkyrh diadromh", out)
        self.assertNotIn("Gia poies metriseis", out)

    def test_missing_downstream_is_detected(self):
        self.evaluate("(unmake-instance [manhole_9])")
        self.assertEqual(tuple(self.evaluate("(path-to-station [manhole_1])")), ())
        self.assertEqual(str(self.evaluate("(validate-knowledge)")), "FALSE")

    def test_missing_chemical_is_detected(self):
        self.evaluate("(unmake-instance [petrol])")
        self.assertEqual(str(self.evaluate("(validate-knowledge)")), "FALSE")

    def test_missing_monitoring_station_is_detected(self):
        self.evaluate("(unmake-instance [monitoring_station])")
        self.assertEqual(str(self.evaluate("(validate-knowledge)")), "FALSE")

    def test_indistinguishable_sources_terminate(self):
        self.evaluate("(make-instance [store_twin] of Store (connectedManhole [manhole_3]) (containsChemical [rubidium_hydroxide]))")
        out = self.run_input("spectrometry radioactivity\nmetal\nyes\n")
        self.assertIn("H phgh paramenei asafhs", out)
        self.assertIn("store_twin", out)
        self.assertNotIn("Yparxei molynsh sto freatio", out)

    def test_arbitrary_names_and_additional_warehouse(self):
        self.evaluate("(make-instance [junction_extra] of Manhole (downstream [monitoring_station]))")
        self.evaluate("(make-instance [warehouse_extra] of Store (connectedManhole [junction_extra]) (containsChemical [petrol]))")
        self.assertEqual(str(self.evaluate("(validate-knowledge)")), "TRUE")
        self.assertIn("warehouse_extra", self.names("(stores-containing-any (create$ [petrol]))"))
        split = str(self.evaluate("(best-splitting-manhole (create$ [warehouse_extra] [store_4]) (create$))"))
        self.assertIn(split, {"junction_extra", "manhole_12"})
        self.assertEqual(self.names("(filter-stores-by-manhole [junction_extra] yes (create$ [warehouse_extra] [store_4]))"), {"warehouse_extra"})

    def test_ontology_matches_embedded_clips_instances(self):
        embedded = {str(instance.name): repr(dict(instance)) for instance in self.env.instances()}
        self.evaluate("(unmake-instance *)")
        self.env.load_instances(str(ROOT / "ontology/pollution.pins"))
        imported = {str(instance.name): repr(dict(instance)) for instance in self.env.instances()}
        self.assertEqual(imported, embedded)

    def test_protege_references_portable_files(self):
        project = (ROOT / "ontology/pollution.pprj").read_text(encoding="utf-8")
        self.assertIn('(string_value "pollution.pont")', project)
        self.assertIn('(string_value "pollution.pins")', project)
        self.assertNotIn("ΣυστήματαΓνώσης.pont", project)
        self.assertNotIn("ΣυστήματαΓνώσης.pins", project)


if __name__ == "__main__":
    unittest.main()
