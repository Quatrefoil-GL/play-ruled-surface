
Play ruled surface
----

> Based on [Quatrefoil](https://github.com/Quatrefoil-GL/quatrefoil).

Demo https://r.tiye.me/Quatrefoil-GL/play-ruled-surface/

### Workflow

https://github.com/Quatrefoil-GL/quatrefoil-workflow

### Development

Use Calcit/procs 0.29.3, Caps 0.1.1, Node 24 and Yarn 4.18.0.
The maintained sources are `calcit.cirru` and `deps.cirru`; generated `js-out`
is ignored. The retired `compact.cirru` remains recoverable from Git history.

```sh
caps --strict --ci
yarn install --immutable
caps verify --toolchain
yarn compile
yarn dev
```

For live source compilation, run `calcit -w js` in a separate terminal.
Published modules are Quaternion 0.2.12, Touch 0.0.29, Pointed Prompt 0.0.17,
Quatrefoil 0.1.6 and transitive js-ffi 0.2.2, without conflict overrides.

### Migration and deployment

Nominal Quaternion/V3 values, named ChordPair data and checked callback contracts
preserve the original formulas and sample density. Renderer boundaries convert
points to xyz lists. Cycloid and chord use separate state branches.
The 237-definition check and full strict gate pass; open heterogeneous state
boundaries remain, so this is not a claim of complete type closure.

Native/JS math replay preserves 600 cycloid segments and 41 chord points.
Browser acceptance covers all five scenes, 11 fractal-line options, six tree
options, chord click generation, and cycloid parameter changes retained across
scene switches. An ignored temporary copy used closer camera framing; the
original production scale/camera are unchanged. VR/gamepad and simultaneous
multi-touch were not tested.

`VITE_BASE_URL` selects the CDN asset base, defaulting to relative paths.
Actions uses Node 24, immutable dependencies and the complete strict gate.
Same-repository PR uploads have isolated run/attempt prefixes. COS v1.2.0 checks
every uploaded file through `public-base-url`, without a separate verifier.
Only main deploys to the unchanged rsync destination. Local CDN builds and
workflow lint pass; actual Actions/COS and production deployment still need
verification.

### License

MIT
