SuperDirt.stop;

MIDIClient.init;

~midiOut = MIDIOut.newByName("OP-Z", "OP-Z");

~dirt.soundLibrary.addMIDI(\opz, ~midiOut);

