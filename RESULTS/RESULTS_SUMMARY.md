# UART RTL-to-GDSII Results

This summary is transcribed from the internship report supplied for this repository. Page references point to the report, not to a fresh simulation run performed in this repository.

## Functional RTL simulation

Source: internship report, page 24 (Figure 5.2).

The displayed GTKWave capture shows:
- Transmit count reaches 4.
- Receive count reaches 3.
- Pass count reaches 3.
- Fail count remains 0.
- Transmitted data shown: `0x41`, `0x55`, `0xA5`, `0xFF`.
- Received data shown through the capture: `0x41`, `0x55`, `0xA5`.

**Capture limitation:** The displayed waveform ends with three received bytes. It does not show the fourth byte (`0xFF`) being received, so this figure alone does not establish a completed 4/4 test.

## Post-layout gate-level simulation

Source: internship report, page 33 (Figure 9.1).

The displayed post-layout waveform likewise shows:
- Transmit count: 4.
- Receive count: 3.
- Pass count: 3.
- Fail count: 0.

The capture shows received bytes `0x41`, `0x55`, and `0xA5`; reception of `0xFF` is not visible in the figure.

## Static timing analysis

Source: internship report, page 32 (Figure 8.1).

The timing report shows two paths:
- Minimum/hold path slack: `3.36` — marked `slack (MET)`.
- Maximum/setup path slack: `7.90` — marked `slack (MET)`.

The report screenshot does not explicitly show a unit beside the slack values. WNS/TNS summary values are not provided in the displayed figure.

## Physical design evidence

The internship report includes:
- Fully routed layout: page 30 (Figure 7.7).
- Final GDSII layout viewed in KLayout: page 35 (Figure 10.3).

## DRC/LVS evidence gap

The report contains DRC and LVS sections and figure captions on page 34, but the supplied page does not show the actual DRC/LVS report outputs or pass/fail counts. Do not treat those captions alone as a verifiable sign-off result.

## Metrics still to add

The report's abstract and conclusion retain placeholders for final utilisation, WNS/TNS, and DRC/LVS status. Add the actual tool-generated values when available.

## Reproduction note

These are observations from figures in the supplied internship report. They are not a substitute for committing the raw simulator console log, VCD file, synthesis reports, OpenROAD reports, and KLayout DRC/LVS outputs from the corresponding runs.
