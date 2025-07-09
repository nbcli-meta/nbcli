/*RUN*/

s.boot;


(
MIDIIn.connect;

~keys;
~instruments;
~keys = Array.newClear(128);
//
~instruments = Array.newClear(16);
~instruments.put(0, \badeda);
~instruments.put(1, \dirtydrum);
~instruments.put(2, \crazy);
~instruments.put(3, \endemind);
~instruments.put(4, \exit);
~instruments.put(5, \hello);
~instruments.put(6, \ladee);
~instruments.put(7, \sbs);
~instruments.put(8, \subvert);
/*~instruments.put(9, \arp);
~instruments.put(10, \forma);
~instruments.put(11, \atmos);
~instruments.put(12, \material0);
~instruments.put(13, \material1);
~instruments.put(14, \material2);
~instruments.put(15, \material3);*/
//
~noteOnFunc = {arg val, num, chan, src;
	var node;
	node = ~keys.at(num);
	if (node.notNil, {
		node.release;
		~keys.put(num, nil);
	});
	node = Synth(~instruments.at(chan), [\freq, num.midicps, \vel, val]);
	[val, num, chan].postln;
	~keys.put(num, node);
};
//
MIDIdef.noteOn(\on, ~noteOnFunc);
//
~noteOffFunc = {arg val, num, chan, src;
	var node;
	node = ~keys.at(num);
	if (node.notNil, {
		node.release;
		~keys.put(num, nil);
	});
};
//
MIDIdef.noteOff(\off, ~noteOffFunc);
//

a = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/badeda.wav");
b = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/dirtydrum.wav"); // remember to free the buffer later.
c = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/crazy.aiff");
d = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/endemind.aiff");
e = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/exit.aiff");
f = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/hello.aiff");
g = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/ladee.aiff");
h = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/sbs.aiff");
i = Buffer.read(s, "/Users/magfoto/_studio/material/sound-clips/subvert.aiff");

SynthDef(\badeda, {| out = 0, bufnum = 0, \bufnum = a|
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: Done.freeSelf)
    )
}).add;


SynthDef(\dirtydrum, {| out = 0, bufnum = 0 |
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: Done.freeSelf)
    )
}).add(s, [\out, 0, \bufnum, b]);

SynthDef(\crazy, {| out = 0, bufnum = 0 |
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: Done.freeSelf)
    )
}).add(s, [\out, 0, \bufnum, c]);


SynthDef(\endemind, {| out = 0, bufnum = 0 |
    Out.ar(out,
        PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), doneAction: Done.freeSelf)
    )
}).add(s, [\out, 0, \bufnum, d]);

)

