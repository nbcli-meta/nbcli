/*RUN*/

s.boot;

(
MIDIIn.connect;
Server.default.options.device_("Virtual Audio Loops");
s.options.sampleRate = 44100;

~keys;
~instruments;
~keys = Array.newClear(128);
//
~instruments = Array.newClear(16);
~instruments.put(0, \kick);
~instruments.put(1, \snare);
~instruments.put(2, "sosTom");
~instruments.put(3, \sine0);
~instruments.put(4, \triangle0);
~instruments.put(5, \sawtooth0);
~instruments.put(6, \cricket);
~instruments.put(7, \bass);
~instruments.put(8, \lead);
~instruments.put(9, \arp);
~instruments.put(10, \forma);
~instruments.put(11, \atmos);
~instruments.put(12, \material0);
~instruments.put(13, \material1);
~instruments.put(14, \material2);
~instruments.put(15, \material3);
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



SynthDef("kick", { arg out = 0, amp = 1, sinFreq = 60, glissf = 0.9, att = 0.01, rel = 0.45, pan = 0;
	var gliss = XLine.kr(sinFreq, sinFreq*glissf, rel);
	var snd = SinOsc.ar(gliss);
	var env = Env.perc(att, rel).kr(doneAction: 2);
	snd = snd * env * amp;
	Out.ar(out, Pan2.ar(snd, pan));
},
metadata: (
	credit: "Bruno Tucunduva Ruviaro",
	category: \drums,
	tags: [\percussion, \kick]
)
).add;

SynthDef("snare", { arg gate = 1, out = 0, amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, freq = 2000, pan = 0;
	var snd1 = WhiteNoise.ar(amp);
	var snd2 = SinOsc.ar(sinfreq,0,amp);
	var env = Env.perc(att, rel).kr(doneAction: 2);
	var mix = HPF.ar(snd1, freq) + snd2;
	mix = mix * env;
	mix = EnvGen.kr(Env.asr, gate, doneAction: 2) * mix;
	Out.ar(out, Pan2.ar(mix, pan));
},
metadata: (
	credit: "Bruno Tucunduva Ruviaro",
	category: \drums,
	tags: [\percussion, \snare]
)
).add;

/* Retrieved from
http://sccode.org/1-5aD
DrumSynths SC Example - SOS Drums by Renick Bell, renick_at_gmail.com
recipes from Gordon Reid in his Sound on Sound articles
SOStom -------
http://www.soundonsound.com/sos/Mar02/articles/synthsecrets0302.asp
Modified by Bruno Ruviaro and Josh Mitchell 8/19.
*/

SynthDef("sosTom", {
	arg gate = 1, out = 0, pan = 0, drumRel = 0.4, stickRel = 0.01, drumModeAmp = 0.25, freq = 250, timbreIndex = 0.77, amp = 0.5, att = 0.005, curve = -6;

	var drumMode, drumModeEnv, stick, stickEnv, snd;

	drumModeEnv = Env.perc(
		            attackTime: att,
		            releaseTime: drumRel,
		            level: 0.25,
		            curve: curve).kr(doneAction: 2);

	drumMode = PMOsc.ar(
		            carfreq: Saw.ar(freq: freq * 0.9),
					modfreq: freq * 0.85,
					pmindex: timbreIndex,
					mul: drumModeEnv * 10);

	drumMode = drumMode + SinOsc.ar(freq: [freq, freq * 0.8], mul: drumModeEnv);

	drumMode = Mix.ar(drumMode) * drumModeAmp;

	stick = Crackle.ar(chaosParam: 2.01);

	stickEnv = Env.perc(attackTime: att, releaseTime: stickRel, level: 3, curve: curve).kr;

	snd = Mix.ar(drumMode + stickEnv) * amp;

	snd = LeakDC.ar(snd);

	snd = EnvGen.kr(Env.asr, gate, doneAction: 2) * snd;

    Out.ar(out, Pan2.ar(snd, pan));

},
metadata: (
	credit: "Renick Bell",
	category: \drums,
	tags: [\pitched, \tom, \sos]
	)
).add;

SynthDef.new(\sine0, {
	arg freq = 440, gate = 1, amp = 0.5;
	var x;
    x = SinOsc.ar(freq, 0, 0.1) + PinkNoise.ar(0.01);
    x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\triangle0, {
	arg freq = 220, gate = 1;
	var x;
	x = LFTri.ar(freq, 0, 0.1);
    x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\sawtooth0, {
	arg freq = 220, gate = 1;
	var x;
	x = LFSaw.ar(freq, 0, 0.1);
    x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\cricket, {
	arg freq = 200, gate = 1;
	var x;
	x = SinOsc.ar(freq,0,0.1) * LFPulse.ar(20, 0, 0.05);
    x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\bass, {
	arg freq = 100, gate = 1;
	var x;
	x = SinOsc.ar(Vibrato.ar(DC.ar(freq),1,0.02) );
    x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\lead, {
	arg freq = 100, gate = 1;
	var x;
	x = FreqShift.ar(SinOsc.ar(Rand(20,freq)),XLine.kr(1,500,5),0,[0.1,0.1]);
    x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\arp, {
	arg freq = 440, gate = 1;
	var x;
	x = VarSaw.ar(LFPulse.kr(3, 0, 0.3, 200, 200),0,LFTri.kr(1.0).range(0,1), 0.1);
	x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\forma, {
	arg freq = 440, gate = 1;
	var x;
    x = Formant.ar(XLine.kr(freq,1000, 8), 2000, 800, 0.125);
    x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\atmos, {
	arg freq = 440, gate = 1;
	var x;
	x = Blip.ar(freq,Line.kr(1,100,20),0.2);
	x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\material0, {
	arg freq = 440, gate = 1;
	var x;
	x = ( Blip.ar(freq,Line.kr(1,100,20),0.2) ) * LorenzL.ar(
		SampleRate.ir,
		LFNoise0.kr(1, 2, 10),
		LFNoise0.kr(1, 20, 38),
		LFNoise0.kr(1, 1.5, 2) )* 0.2;
	x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\material1, {
	arg freq = 440, gate = 1;
	var x;
	x = DynKlank.ar(`[[freq*2, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1));
	x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\material2, {
	arg freq = 440, gate = 1;
	var x;
	x = Blip.ar(freq,Line.kr(1,100,20),0.2) * DynKlank.ar(`[[freq*2, 1071, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1));
	x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

SynthDef.new(\material3, {
	arg freq = 440, gate = 1;
	var x;
	x = SinOsc.ar(freq,Line.kr(1,100,20),0.2) - Delay1.ar(SinOsc.ar(freq/2,Line.kr(1,100,20),0.2) - Blip.ar(freq,Line.kr(1,100,20),0.2));
	x = EnvGen.kr(Env.asr, gate, doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x));
}).add;

)

