<Cabbage> bounds(0, 0, 0, 0)
form caption("Untitled") size(400, 300), colour(58, 110, 182), pluginid("def1")
rslider bounds(290, 32, 100, 100), channel("brainGain"), range(-6, 6, 1, 1, 0.01), text("Brain"), trackercolour(0, 255, 0, 255), outlinecolour(0, 0, 0, 50), textcolour(0, 0, 0, 255)
rslider bounds(152, 32, 100, 100), channel("brassGain"), range(-6, 6, 1, 1, 0.01), text("Brass"), trackercolour(0, 255, 0, 255), outlinecolour(0, 0, 0, 50), textcolour(0, 0, 0, 255)
rslider bounds(10, 32, 100, 100), channel("boomGain"), range(-6, 6, 1, 1, 0.01), text("Boom"), trackercolour(0, 255, 0, 255), outlinecolour(0, 0, 0, 50), textcolour(0, 0, 0, 255)
rslider bounds(274, 186, 100, 100), channel("outGain"), range(0, 1, 0, 1, 0.01), text("Output"), trackercolour(0, 255, 0, 255), outlinecolour(0, 0, 0, 50), textcolour(0, 0, 0, 255)

button bounds(10, 242, 80, 40) text("Brightness", "Brightness") colour:1(255, 255, 0, 255) fontcolour:1(0, 0, 0, 255) channel("bright")
</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-n -d -+rtmidi=NULL -M0 -m0d 
</CsOptions>
<CsInstruments>
; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1


instr 1
kGain chnget "outGain"
kBoom chnget "boomGain"
kBrain chnget "brainGain"
kBrass chnget "brassGain"
kBright chnget "bright"

;- Region: Input Section

;a1 inch 1
;a2 inch 2
a1, a2 diskin2	"bassCR.wav", 1, 0, 1


ares pareq a1, 120, kBoom, 0.15,0
ares2 pareq a1, 550, kBrass, 0.15, 0
ares3 pareq a1, 1230.05, kBrain, 0.15,0

aSum = a1+a2

aBright exciter a1, 3000, 15000.07, 10, 6
aBright2 exciter a2, 3000, 15000.07, 10, 6

;aBright pareq aSum, 12000.07, 3, 0.25, 0

a1 = ares+ares2+ares3
a2 = ares+ares2+ares3

;- Region: Output Section

if kBright == 1 then
outs a1+aBright*kGain, a1+aBright2*kGain
else 
outs a1*kGain, a2*kGain
endif

;outs a1*kGain, a2*kGain
endin

</CsInstruments>
<CsScore>
;causes Csound to run for about 7000 years...
f0 z
;starts instrument 1 and runs it for a week
i1 0 [60*60*24*7] 
</CsScore>
</CsoundSynthesizer>
