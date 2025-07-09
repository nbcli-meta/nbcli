s.boot;

(
s.meter;
s.plotTree;
s.scope;
)

b =  Buffer.readChannel(s, "/Users/magfoto/_studio/material/sound clips/turing_poly.wav", channels:[0]);
b.play;

b.numChannels;
b.free;

FreqScope.new;

(
{

var sig;
sig = GrainBuf.ar(
	1,
		Impulse.ar([60,60.5]),
		MouseX.kr(0.0002,0.1,1).poll,
	b,
	1,
	0.23,
	2,
	0,
	-1,
	512
);
}.play
)