/*RUN*/

s.boot;

SuperDirt.start;

(
MIDIIn.connect;
Server.default.options.device_("Virtual Audio Loops");
s.options.sampleRate = 44100;

~midiOut = MIDIOut.newByName("OP-Z", "OP-Z");
~dirt.soundLibrary.addMIDI(\opz, ~midiOut);

(
    SynthDef(\pitch, {
      |
      out,
      n,
      channel,
      stepsPerOctave = 12,
      rate = 1,
      delta,
      begin,
      end,
      portamento = 0 |
      var slew, env, phase;
      n = n + (stepsPerOctave / 12);
      n = (n + (n / stepsPerOctave) * (1 / (stepsPerOctave + 1)) / 10);
      slew = (portamento);
      slew = (slew + (slew / stepsPerOctave) * (1 / (stepsPerOctave + 1)) / 10);
      env = Env([n, n + slew], [delta / rate]);
      phase = Line.ar(begin, end, delta / rate);
      OffsetOut.ar(channel, IEnvGen.ar(env, phase));
    }).add
  );

  (
    SynthDef(\gate, {
      |
      out,
      channel,
      amp,
      n |
      n = n * 5;
      OffsetOut.ar(channel, DC.ar(n) * amp);
    }).add
  );

  (
    SynthDef(\voltage, {
      |
      out,
      channel,
      n,
      rate = 1,
      delta,
      begin,
      amp = 1,
      end,
      portamento = 0 |
      var slew, env, phase;
      n = n * 5;
      slew = (portamento);
      rate = rate;
      env = Env([n, n + slew], [delta / rate]);
      phase = Line.ar(begin, end, delta / rate);
      OffsetOut.ar(channel, EnvGen.ar(env, phase) * amp);
    }).add
  );

  (
    SynthDef(\saw, {
      |
      out,
      channel,
      amp = 1,
      rate = 0.5 |
      OffsetOut.ar(channel, abs(Saw.ar(rate)) * amp);
    }).add;
  );

  (
    SynthDef(\lfo, {
      |
      out,
      channel,
      amp = 1,
      rate = 0.5 |
      OffsetOut.ar(channel, K2A.ar(abs(SinOsc.ar(rate, 0)) * amp));
    }).add;
  );

  (
    SynthDef(\ar, {
      |
      out,
      channel,
      attack = 0.01,
      decay = 0.25,
      sustain = 0.25,
      release = 0.25,
      begin,
      amp = 1,
      end |
      var env, phase;
      env = Env.adsr(attack, decay, sustain, release);
      phase = Line.ar(begin, end, sustain);
      OffsetOut.ar(channel, IEnvGen.ar(env, phase) * amp);
    }).add
  );

  (
    SynthDef(\nPitch, {
      | out,
      channel = 0, 
      freq = 440, 
      portamento = 0 |
      var n = Lag.ar(log2(K2A.ar(freq)/440), portamento);
      var sig = LinLin.ar(n, -1, 9, 0, 1);
      OffsetOut.ar(channel, [sig]);
    }).add
  );

   (
    SynthDef(\nGate, {
      | out,
      channel = 0, 
      n, 
      portamento = 0 |
      var sig = LinLin.ar(n, -1, 9, 0, 1);
      OffsetOut.ar(channel, [sig]);
    }).add
  );


)
