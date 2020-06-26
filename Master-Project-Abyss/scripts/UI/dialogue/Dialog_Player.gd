extends Node

func play_dialog(record_name : String):
	self._playing_dialog = true
	self._did = self._Story_Reader.get_did_via_record_name(record_name)
	self._nid = self._Story_Reader.get_nid_via_exact_text(self._did, "<start>")
