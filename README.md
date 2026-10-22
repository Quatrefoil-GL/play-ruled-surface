
Play ruled surface
----

> Based on [Quatrefoil](https://github.com/Quatrefoil-GL/quatrefoil).

Demo https://r.tiye.me/Quatrefoil-GL/play-ruled-surface/

### Workflow

https://github.com/Quatrefoil-GL/quatrefoil-workflow

### Development

Use paired formal Calcit/procs 0.30.1, Caps 0.1.1, Node 24 and Yarn 4.18.0.
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
Published modules are Quaternion 0.2.16, Touch 0.0.32, Pointed Prompt 0.0.20,
Quatrefoil 0.1.10 and transitive js-ffi 0.2.5, without conflict overrides.

### Migration and deployment

The 0.30.1 candidate preserves the existing source byte-for-byte, including
the nominal vector contracts, five scenes, camera/scale, sample density and
`hud!` page-error display. The earlier 0.30.0 results below are historical
evidence, not acceptance of the updated dependency graph. Exact candidate CI
and browser results are recorded in its PR; production deployment is separate.

Nominal Quaternion/V3 values, named ChordPair data and checked callback contracts
preserve the original formulas and sample density. Renderer boundaries convert
points to xyz lists. Cycloid and chord use separate state branches.
The 237-definition check, all 26 public project definitions and the full strict
gate (235 reachable definitions) pass. Old Option helpers use method calls or
explicit matching at heterogeneous state boundaries; literal `case-default`
branches use `match`, identity `wo-log` wrappers are removed, and the store uses
`defref`. Checked decoders remain in place. Twelve unresolved Dynamic positions
in seven definitions remain; this is not a claim of complete type closure.

For this upgrade, an ignored math probe passes five assertions under the old
0.29.3/formal module graph and new 0.30.0/formal graph in native mode, and under
the new graph in an actual browser: 600 cycloid segments, first xyz point, 41
chord points and both endpoints. The formulas, branch bodies, sample parameters
and metadata of 13 math definitions were compared through official query views.
The original project has no attached test suite. Its browser entry starts
without errors; the original production scale/camera leave the scene very small.
The older migration's five-scene/11-line/six-tree interaction acceptance used an
ignored closer-camera copy and was not repeated for this upgrade. VR/gamepad
and simultaneous multi-touch remain untested. Node execution of the browser
math modules is not supported by the existing `@quatrefoil/utils` packaging;
the successful JS math evidence is from the browser, not Node.

`VITE_BASE_URL` selects the CDN asset base, defaulting to relative paths.
Actions uses Node 24, immutable dependencies and the complete strict gate.
Same-repository PR uploads have isolated run/attempt prefixes. COS v1.2.0 checks
every uploaded file through `public-base-url`, without a separate verifier.
Only main deploys to the unchanged rsync destination. Local CDN builds and
workflow lint pass. PR Actions/COS must be verified for the exact submitted
commit; production deployment requires separate authorization and is not part
of the local acceptance above.

### License

MIT
