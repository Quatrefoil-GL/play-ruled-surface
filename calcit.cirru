
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/ |quaternion/
      :type-slots $ {}
  :files $ {}
    'app.comp.chord-fiber $ %{} 'FileEntry
      :defs $ {}
        'ChordPair $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct ChordPair (:p1 'quaternion.core/Quaternion) (:p2 'quaternion.core/Quaternion) (:angle 'Number)
          :examples $ []
          :schema $ :: 'StructDef
        'comp-chord-fiber $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-chord-fiber (states)
            let
                cursor $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get states :cursor
                    , .unwrap
                  :: 'List 'Tag
                state $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  or
                    match (get states :data)
                      (:some found) found
                      (:none) nil
                    {} $ :fibers $ []
                  :: 'Map 'Tag 'Dynamic
              group ({})
                sphere $ {} (:radius 1) (:width-segments 10) (:height-segments 10)
                  :position $ [] 0 0 0
                  :material $ {} (:kind :mesh-lambert) (:color 0x808080) (:opacity 0.6)
                  :on $ {} $ :click
                    fn (e d!)
                      let
                          pairs $ -> (range 50)
                            map $ fn (idx) (generate-segment)
                        d! cursor $ assoc state :fibers pairs
                group ({}) & $ ->
                  map
                    quatrefoil.util.core/require-decoded $ try-decode-map-as
                        get state :fibers
                        , .unwrap
                      :: 'List 'Dynamic
                    fn (pair)
                      hint-fn $ {}
                        :args $ [] 'Dynamic
                        :return 'app.comp.chord-fiber/ChordPair
                      if (struct? pair)
                        if (&struct:matches? pair ChordPair) pair $ raise |expected-ChordPair-in-fibers
                        raise |expected-ChordPair-in-fibers
                  map $ fn (pair)
                    let
                        p1 $ :p1 pair
                        p2 $ :p2 pair
                        angle $ :angle pair
                      group ({})
                        ; sphere $ {} (:position p1) (:radius 1) (:width-segments 10) (:height-segments 10)
                          :position $ [] 0 0 0
                          :material $ {} (:kind :mesh-lambert) (:color 0xff8080) (:opacity 0.6)
                        ; sphere $ {} (:position p2) (:radius 1) (:width-segments 10) (:height-segments 10)
                          :position $ [] 0 0 0
                          :material $ {} (:kind :mesh-lambert) (:color 0x8080ff) (:opacity 0.2) (:transparent true)
                        mesh-line $ {}
                          :points $ map (lerp-chord p1 p2)
                            fn (q)
                              match q $
                                :quaternion w x y z
                                [] x y z
                          :position $ [] 0 0 0
                          :material $ {} (:kind :mesh-line)
                            :color $ hslx
                              -> angle (/ &PI) (* 180)
                              , 90 $ quatrefoil.core/js-number (rand-between 40 75)
                            :transparent true
                            :opacity 0.9
                            :depthTest true
                            :lineWidth 0.5
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Shape)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
            :features $ #{} :js-ffi
        'generate-segment $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn generate-segment ()
            let
                r 50
                bottom 8
                dy $ -
                  quatrefoil.core/js-number $ rand bottom
                  , r
                dy2 $ - r $ quatrefoil.core/js-number
                  rand $ - (* 2 r) bottom
                angle $ quatrefoil.core/js-number $ rand-between 0 (* 2 &PI)
                angle2 $ quatrefoil.core/js-number $ rand-between 0 (* 2 &PI)
                r1 $ sqrt $ - (* r r) (* dy dy)
                p1 $ quaternion 0
                  * r1 $ cos angle
                  , dy $ * r1 (sin angle)
                r2 $ sqrt $ - (* r r) (* dy2 dy2)
                p2 $ quaternion 0
                  * r2 $ cos angle2
                  , dy2 $ * r2 (sin angle2)
              ChordPair :p1 p1 :p2 p2 :angle angle2
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'app.comp.chord-fiber/ChordPair)
            :args $ []
            :features $ #{} :js-ffi
        'lerp-chord $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn lerp-chord (p1 p2)
            let
                n 40
                d $ &q- p2 p1
                unit $ &q* d $ quaternion (/ 1 n) 0 0 0
              -> (range n)
                map $ fn (idx)
                  let
                      p $ &q+ p1 $ &q* unit (quaternion idx 0 0 0)
                      ratio $ / idx n
                    &q+
                      &q* p1 $ quaternion
                        pow (- 1 ratio) 2
                        , 0 0 0
                      &q* p2 $ quaternion (pow ratio 2) 0 0 0
                append p2
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'quaternion.core/Quaternion 'quaternion.core/Quaternion
            :return $ :: 'List 'quaternion.core/Quaternion
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.chord-fiber
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text line tube mesh-line
            quatrefoil.core :refer $ defcomp >> hslx
            quatrefoil.comp.control :refer $ comp-pin-point
            quatrefoil.app.materials :refer $ cover-line
            quaternion.core :refer $ quaternion &q+ &q- &q*
            app.comp.tabs :refer $ comp-tabs
            |@calcit/std :refer $ rand-between rand
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (store)
            let
                states $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get store :states
                    , .unwrap
                  :: 'Map 'Tag 'Dynamic
                cursor $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get states :cursor
                    , .unwrap
                  :: 'List 'Tag
                state $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  either
                    match (get states :data)
                      (:some found) found
                      (:none) nil
                    {} $ :tab :fractal-line
                  :: 'Map 'Tag 'Dynamic
                tab $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :tab
                    , .unwrap
                  , 'Tag
                scaled 0.02
              scene ({})
                group
                  {}
                    :scale $ [] scaled scaled scaled
                    :position $ [] 0 1 -0.2
                  comp-tabs
                    {}
                      :tabs $ [] :ruled-surface :fractal-line :fractal-tree :chord-fiber :cycloid-mesh
                      :selected tab
                      :position $ [] -20 0 -30
                    fn (tab d!)
                      d! cursor $ assoc state :tab tab
                  match tab
                    :ruled-surface $ comp-ruled-surface $ quatrefoil.util.core/require-decoded
                      try-decode-map-as (>> states :ruled) (:: 'Map 'Tag 'Dynamic)
                    :fractal-line $ comp-fractal-line $ quatrefoil.util.core/require-decoded
                      try-decode-map-as (>> states :fractal-line) (:: 'Map 'Tag 'Dynamic)
                    :fractal-tree $ comp-fractal-tree $ quatrefoil.util.core/require-decoded
                      try-decode-map-as (>> states :fractal-tree) (:: 'Map 'Tag 'Dynamic)
                    :chord-fiber $ comp-chord-fiber $ quatrefoil.util.core/require-decoded
                      try-decode-map-as (>> states :chord-fiber) (:: 'Map 'Tag 'Dynamic)
                    :cycloid-mesh $ comp-cycloid-mesh $ quatrefoil.util.core/require-decoded
                      try-decode-map-as (>> states :cycloid) (:: 'Map 'Tag 'Dynamic)
                    _ $ text $ {} (:size 2) (:depth 0.5)
                      :text $ str "|Unknown tab " tab
                      :position $ [] 0 0 0
                      :material $ {} (:kind :mesh-lambert) (:color 0xffff33) (:opacity 1)
                  group
                    {} $ :position $ [] -10 0 20
                    point-light $ {} (:color 0xffff33) (:intensity 2) (:distance 100)
                    ; sphere $ {} (:radius 0.6) (:width-segments 10) (:height-segments 10)
                      :material $ {} (:kind :mesh-lambert) (:color 0xffff33) (:opacity 1)
                  ambient-light $ {} (:color 0xffff00) (:intensity 1)
                  ; point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                    :position $ [] 20 40 50
                  ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                    :position $ [] 0 60 0
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Component)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
        'comp-ruled-surface $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-ruled-surface (states)
            let
                cursor $ require-decoded $ try-decode-map-as
                    get states :cursor
                    , .unwrap
                  :: 'List 'Tag
                state $ require-decoded $ try-decode-map-as
                  or
                    match (get states :data)
                      (:some found) found
                      (:none) nil
                    {}
                      :s0 $ vector/v3 0 0 0
                      :s1 $ vector/v3 10 0 0
                      :e0 $ vector/v3 0 10 1
                      :e1 $ vector/v3 10 10 1
                  :: 'Map 'Tag 'Dynamic
                s0 $ require-decoded $ try-decode-map-as
                    get state :s0
                    , .unwrap
                  , 'quaternion.vector/V3
                s1 $ require-decoded $ try-decode-map-as
                    get state :s1
                    , .unwrap
                  , 'quaternion.vector/V3
                e0 $ require-decoded $ try-decode-map-as
                    get state :e0
                    , .unwrap
                  , 'quaternion.vector/V3
                e1 $ require-decoded $ try-decode-map-as
                    get state :e1
                    , .unwrap
                  , 'quaternion.vector/V3
                step 40
                v0 $ vector/v-scale (vector/&v- e0 s0) (/ 1 step)
                v1 $ vector/v-scale (vector/&v- e1 s1) (/ 1 step)
              group ({})
                comp-pin-point
                  {} (:speed 0.1) (:color 0xffffaa) (:position s0)
                  fn (p d!)
                    d! cursor $ assoc state :s0 p
                comp-pin-point
                  {} (:speed 0.1) (:color 0xffffaa) (:position s1)
                  fn (p d!)
                    d! cursor $ assoc state :s1 p
                comp-pin-point
                  {} (:speed 0.1) (:color 0xffffaa) (:position e0)
                  fn (p d!)
                    d! cursor $ assoc state :e0 p
                comp-pin-point
                  {} (:speed 0.1) (:color 0xffffaa) (:position e1)
                  fn (p d!)
                    d! cursor $ assoc state :e1 p
                line $ {}
                  :points $ map ([] s0 e0)
                    fn (point)
                      match point $
                        :v3 x y z
                        [] x y z
                  :position $ [] 0 0 0
                  :material $ assoc cover-line :opacity 0.5
                line $ {}
                  :points $ map ([] s1 e1)
                    fn (point)
                      match point $
                        :v3 x y z
                        [] x y z
                  :position $ [] 0 0 0
                  :material $ assoc cover-line :opacity 0.5
                group ({}) & $ ->
                  range $ inc step
                  map $ fn (idx)
                    mesh-line $ {}
                      :points $ map
                        []
                          vector/&v+ s0 $ vector/v-scale v0 idx
                          vector/&v+ s1 $ vector/v-scale v1 idx
                        fn (point)
                          match point $
                            :v3 x y z
                            [] x y z
                      :position $ [] 0 0 0
                      :material $ {} (:kind :mesh-line) (:transparent true) (:opacity 0.9) (:lineWidth 0.4)
                        :color $ hslx
                          * 360 $ quatrefoil.core/js-number $ js/Math.random
                          , 100 80
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Component)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
            :features $ #{} :js-ffi
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light scene text line tube mesh-line
            quatrefoil.core :refer $ defcomp >> hslx
            quatrefoil.comp.control :refer $ comp-pin-point
            quatrefoil.app.materials :refer $ cover-line
            app.comp.fractal-line :refer $ comp-fractal-line
            app.comp.fractal-tree :refer $ comp-fractal-tree
            app.comp.tabs :refer $ comp-tabs
            app.comp.chord-fiber :refer $ comp-chord-fiber
            app.comp.cycloid :refer $ comp-cycloid-mesh
            quaternion.vector :as vector
            quatrefoil.util.core :refer $ require-decoded
    'app.comp.cycloid $ %{} 'FileEntry
      :defs $ {}
        'comp-cycloid-mesh $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-cycloid-mesh (states)
            let
                cursor $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get states :cursor
                    , .unwrap
                  :: 'List 'Tag
                state $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  or
                    match (get states :data)
                      (:some found) found
                      (:none) nil
                    {} (:shape :zero) (:r1 10) (:theta1 0.09) (:r2 5) (:theta2 0.12) (:r3 0) (:theta3 0.16) (:size 600) (:v 1) (:jump 10)
                  :: 'Map 'Tag 'Dynamic
                r1 $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :r1
                    , .unwrap
                  , 'Number
                theta1 $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :theta1
                    , .unwrap
                  , 'Number
                r2 $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :r2
                    , .unwrap
                  , 'Number
                theta2 $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :theta2
                    , .unwrap
                  , 'Number
                r3 $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :r3
                    , .unwrap
                  , 'Number
                theta3 $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :theta3
                    , .unwrap
                  , 'Number
                size $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :size
                    , .unwrap
                  , 'Number
                jump $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :jump
                    , .unwrap
                  , 'Number
                v $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :v
                    , .unwrap
                  , 'Number
                theta-bound $ [] 0.001 0.6
                color $ hslx 200 90 70
              group ({})
                group
                  {} $ :position $ [] 0 -10 0
                  comp-value
                    {} (:label |r1) (:radius 1) (:speed 0.2) (:fract-length 2) (:opacity 0.8) (:show-text? true) (:color color) (:value r1)
                      :position $ [] 50 20 0
                      :bound $ [] 1 20
                    fn (v d!)
                      d! cursor $ assoc state :r1 v
                  comp-value
                    {} (:label |r2) (:radius 1) (:speed 0.2) (:fract-length 2) (:opacity 0.8) (:show-text? true) (:color color) (:value r2)
                      :position $ [] 50 25 0
                      :bound $ [] 1 r1
                    fn (v d!)
                      d! cursor $ assoc state :r2 v
                  comp-value
                    {} (:label |r3) (:radius 1) (:speed 0.2) (:fract-length 2) (:opacity 0.8) (:show-text? true) (:color color) (:value r3)
                      :position $ [] 50 30 0
                      :bound $ [] 0 r2
                    fn (v d!)
                      d! cursor $ assoc state :r3 v
                  comp-value
                    {} (:label |th1) (:radius 1) (:speed 0.0003) (:opacity 0.8) (:show-text? true) (:fract-length 4) (:bound theta-bound) (:color color) (:value theta1)
                      :position $ [] 30 20 0
                    fn (v d!)
                      d! cursor $ assoc state :theta1 v
                  comp-value
                    {} (:label |th2) (:radius 1) (:speed 0.0003) (:opacity 0.8) (:show-text? true) (:fract-length 4) (:bound theta-bound) (:color color) (:value theta2)
                      :position $ [] 30 25 0
                    fn (v d!)
                      d! cursor $ assoc state :theta2 v
                  comp-value
                    {} (:label |th3) (:radius 1) (:speed 0.001) (:opacity 0.8) (:show-text? true) (:fract-length 4) (:bound theta-bound) (:color color) (:value theta3)
                      :position $ [] 30 30 0
                    fn (v d!)
                      d! cursor $ assoc state :theta3 v
                group
                  {} $ :position $ [] -10 15 0
                  comp-value
                    {} (:radius 1) (:speed 1) (:opacity 0.8) (:show-text? true) (:label |jump) (:fract-length 0) (:color color)
                      :bound $ [] 1 200
                      :value jump
                      :position $ [] 40 10 0
                    fn (v d!)
                      d! cursor $ assoc state :jump v
                  comp-value
                    {} (:radius 1) (:speed 0.1) (:opacity 0.8) (:show-text? true) (:label |v) (:fract-length 2) (:color color)
                      :bound $ [] 0.01 10
                      :value v
                      :position $ [] 50 10 0
                    fn (v d!)
                      d! cursor $ assoc state :v v
                  comp-value
                    {} (:radius 1) (:speed 10) (:opacity 0.8) (:show-text? true) (:label |size) (:fract-length 0) (:color color)
                      :bound $ [] 600 4000
                      :value size
                      :position $ [] 60 10 0
                    fn (v d!)
                      d! cursor $ assoc state :size v
                line-segments $ {}
                  :segments $ gen-trail r1 theta1 r2 theta2 r3 theta3 size jump v
                  :position $ [] 0 0 0
                  :material $ {} (:kind :line-basic) (:color 0xffc6a0) (:transparent true) (:opacity 0.8) (:linewidth 0.1)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Shape)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
        'gen-trail $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn gen-trail
            r1 theta1 r2 theta2 r3 theta3 size jump v
            let
                calc-position $ fn (idx)
                  hint-fn $ {}
                    :args $ [] 'Number
                    :return $ :: 'List 'Number
                  let
                      t $ &* idx v
                      v1 $ vector/v3
                        * r1 $ cos $ * t theta1
                        * r1 $ sin $ * t theta1
                        , 0
                      v2 $ vector/v3
                        * r2 $ cos $ * t theta2
                        , 0 $ * r2
                          sin $ * t theta2
                      v3 $ vector/v3 9
                        * r3 $ cos $ * t theta3
                        * r3 $ sin $ * t theta3
                    match (vector/v+ v1 v2 v3)
                      (:v3 x y z) ([] x y z)
              -> (range size)
                map $ fn (idx)
                  hint-fn $ {}
                    :args $ [] 'Number
                    :return $ :: 'List $ :: 'List 'Number
                  [] (calc-position idx)
                    calc-position $ + idx jump
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'Number 'Number 'Number 'Number 'Number 'Number 'Number 'Number
            :return $ :: 'List $ :: 'List (:: 'List 'Number)
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.cycloid
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text line tube mesh-line line-segments
            quatrefoil.core :refer $ defcomp >> hslx
            quatrefoil.comp.control :refer $ comp-pin-point comp-value
            quatrefoil.app.materials :refer $ cover-line
            quaternion.vector :as vector
    'app.comp.fractal-line $ %{} 'FileEntry
      :defs $ {}
        'build-fractal-path $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn build-fractal-path (tab)
            match tab
              :ice $ fold-line4 9 (quaternion 0 0 0 0) (quaternion 0 100 0 0) (quaternion 27 0 0 0) (quaternion 23 0 -18 0) (quaternion 27 0 0 -18) (quaternion 23 0 0 0)
                q-inverse $ quaternion 50 0 0 0
                , 0.16
              :cable-stayed $ fold-line5 8 (quaternion 0 0 0 0) (quaternion 0 100 0 0) (quaternion 40 0 0 0) (quaternion 20 0 12.5 0) (quaternion 30 0 12.5 12.5) (quaternion 40 0 12.5 0) (quaternion 20 0 0 0)
                q-inverse $ quaternion 60 0 0 0
                , 0.16
              :fly-city $ fold-line4 9 (quaternion 0 0 0 0) (quaternion 0 200 0 0) (quaternion 25 0 20 0) (quaternion 25 5 20 10) (quaternion 15 5 20 10) (quaternion 15 0 20 0)
                q-inverse $ quaternion 50 0 0 0
                , 0.16
              :lamp-tree $ fold-line4 14 (quaternion 0 0 0 0) (quaternion 0 0 100 0) (quaternion 22 0 20 0) (quaternion 23 16 20 0) (quaternion 27 16 20 0) (quaternion 28 0 20 0)
                q-inverse $ quaternion 50 0 0 0
                , 0.16
              :wormhole $ fold-line3 14 (quaternion 0 0 0 0) (quaternion 0 101 0 0) (quaternion 16 21 0 0) (quaternion 20 21 10 0) (quaternion 24 21 0 0)
                q-inverse $ quaternion 40 0 0 0
                , 0.16
              :water-caltrop $ fold-line5-caltrop 10 (quaternion 0 0 0 0) (quaternion 0 100 0 0) (quaternion 13 0 0 0) (quaternion 40 0 0 29) (quaternion 30 0 0 0) (quaternion 20 29 0 0) (quaternion 47 0 0 0)
                q-inverse $ quaternion 60 0 0 0
                , 0.16
              :fold-snow $ fold-line5 10 (quaternion 0 0 0 0) (quaternion 0 100 0 0) (quaternion 20 0 0 0) (quaternion 40 0 0 20) (quaternion 30 0 0 0) (quaternion 20 0 20 0) (quaternion 40 0 0 0)
                q-inverse $ quaternion 60 0 0 0
                , 0.06
              :ingot $ fold-line4 10 (quaternion 0 0 0 0) (quaternion 0 100 0 0) (quaternion 10 0 0 10) (quaternion 20 0 5 0) (quaternion 10 0 5 0) (quaternion 20 0 0 10)
                q-inverse $ quaternion 30 0 0 0
                , 0.16
              :chain $ fold-line2 16 (quaternion 0 0 0 0) (quaternion 0 100 0 0) (quaternion 15 0 3.75 7.5) (quaternion 15 0 -3.75 7.5)
                q-inverse $ quaternion 30 0 0 0
                , 0.0008
              :brozing $ fold-line4 10 (quaternion 0 0 0 0) (quaternion 0 100 0 0) (quaternion 0 0 0 15) (quaternion 10 0 0 0) (quaternion 30 0 0 0) (quaternion 40 0 0 -15)
                q-inverse $ quaternion 40 0 0 0
                , 0.08
              _ $ do (js/console.log |unknown tab)
                [] (quaternion 0 0 0 0) (quaternion 0 0 40 0) (quaternion 0 40 0 0) (quaternion 0 0 0 0)
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Tag
            :features $ #{} :js-ffi
            :return $ :: 'List 'quaternion.core/Quaternion
        'comp-fractal-line $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-fractal-line (states)
            let
                cursor $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get states :cursor
                    , .unwrap
                  :: 'List 'Tag
                state $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  or
                    match (get states :data)
                      (:some found) found
                      (:none) nil
                    {} $ :shape :zero
                  :: 'Map 'Tag 'Dynamic
                shape $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :shape
                    , .unwrap
                  , 'Tag
              group ({})
                comp-tabs
                  {} (:selected shape)
                    :tabs $ [] :ice :fly-city :cable-stayed :water-caltrop :lamp-tree :wormhole :fold-snow :ingot :chain :brozing :try
                    :position $ [] -35 20 -30
                  fn (tab d!)
                    d! cursor $ assoc state :shape tab
                line $ {}
                  :points $ prepend
                    map (build-fractal-path shape)
                      fn (q)
                        match q $
                          :quaternion w x y z
                          [] x y z
                    [] 0 0 0
                  :position $ [] 5 -10 0
                  :material $ {} (:kind :line-basic) (:color 0xffa6a0) (:transparent true) (:opacity 0.6) (:linewidth 0.1)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Shape)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
            :features $ #{} :js-ffi
        'fold-line2 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line2 (level base v a b full' minimal-seg)
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                [] (&q+ base branch-a) (&q+ base branch-b) (&q+ base v)
                concat
                  fold-line2 (dec level) base branch-a a b full' minimal-seg
                  fold-line2 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b full' minimal-seg
                  fold-line2 (dec level) (&q+ base branch-b) (&q- v branch-b) a b full' minimal-seg
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List 'quaternion.core/Quaternion
        'fold-line3 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line3 (level base v a b c full' minimal-seg)
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
                branch-c $ &q* v' c
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                [] (&q+ base branch-a) (&q+ base branch-b) (&q+ base branch-c) (&q+ base v)
                concat
                  fold-line3 (dec level) base branch-a a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c full' minimal-seg
                  fold-line3 (dec level) (&q+ base branch-c) (&q- v branch-c) a b c full' minimal-seg
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List 'quaternion.core/Quaternion
        'fold-line4 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line4
            level base v a b c d full' minimal-seg
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
                branch-c $ &q* v' c
                branch-d $ &q* v' d
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                [] (&q+ base branch-a) (&q+ base branch-b) (&q+ base branch-c) (&q+ base branch-d) (&q+ base v)
                concat
                  fold-line4 (dec level) base branch-a a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-c) (&q- branch-d branch-c) a b c d full' minimal-seg
                  fold-line4 (dec level) (&q+ base branch-d) (&q- v branch-d) a b c d full' minimal-seg
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List 'quaternion.core/Quaternion
        'fold-line5 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line5
            level base v a b c d e full' minimal-seg
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
                branch-c $ &q* v' c
                branch-d $ &q* v' d
                branch-e $ &q* v' e
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                [] (&q+ base branch-a) (&q+ base branch-b) (&q+ base branch-c) (&q+ base branch-d) (&q+ base branch-e) (&q+ base v)
                concat
                  fold-line5 (dec level) base branch-a a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-c) (&q- branch-d branch-c) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-d) (&q- branch-e branch-d) a b c d e full' minimal-seg
                  fold-line5 (dec level) (&q+ base branch-e) (&q- v branch-e) a b c d e full' minimal-seg
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List 'quaternion.core/Quaternion
        'fold-line5-caltrop $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn fold-line5-caltrop
            level base v a b c d e full' minimal-seg
            let
                v' $ &q* v full'
                branch-a $ &q* v' a
                branch-b $ &q* v' b
                branch-c $ &q* v' c
                branch-d $ &q* v' d
                branch-e $ &q* v' e
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                [] (&q+ base branch-a) (&q+ base branch-b) (&q+ base branch-c) (&q+ base branch-d) (&q+ base branch-e) (&q+ base v)
                concat
                  fold-line5-caltrop (dec level) base branch-a a b c d e full' minimal-seg
                  fold-line5-caltrop (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c d e full' minimal-seg
                  fold-line5-caltrop (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c d e full' minimal-seg
                  fold-line5-caltrop (dec level) (&q+ base branch-c) (&q- branch-d branch-c) a b c d e full' minimal-seg
                  fold-line5-caltrop (dec level) (&q+ base branch-d)
                    &q- branch-e $ noted "|has typo here but got really interesting result" branch-e
                    , a b c d e full' minimal-seg
                  fold-line5-caltrop (dec level) (&q+ base branch-e) (&q- v branch-e) a b c d e full' minimal-seg
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List 'quaternion.core/Quaternion
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.fractal-line
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text line tube mesh-line
            quatrefoil.core :refer $ defcomp >> hslx
            quatrefoil.comp.control :refer $ comp-pin-point
            quatrefoil.app.materials :refer $ cover-line
            quaternion.core :refer $ v-scale v+ &v+ &q+ &q- &q* q-inverse q-length2 quaternion
            app.comp.tabs :refer $ comp-tabs
    'app.comp.fractal-tree $ %{} 'FileEntry
      :defs $ {}
        'build-fractal-tree $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn build-fractal-tree (shape)
            match shape
              :cubes $ let
                  inv $ q-inverse $ quaternion 7.5 0 0 0
                expand-branch4 12 (quaternion 0 0 0 0) (quaternion 0 0 50 0)
                  &q* (quaternion 0 4 0 0) inv
                  &q* (quaternion 0 0 0 -4) inv
                  &q* (quaternion 0 -4 0 0) inv
                  &q* (quaternion 0 0 0 4) inv
                  , 0.02
              :tree $ let
                  inv $ q-inverse $ quaternion 10 0 0 0
                expand-branch4 8 (quaternion 0 0 0 0) (quaternion 0 0 50 0)
                  &q* (quaternion 5 4 0 0) inv
                  &q* (quaternion 5 0 0 -4) inv
                  &q* (quaternion 5 0 0 4) inv
                  &q* (quaternion 5 -4 0 0) inv
                  , 0.04
              :umbrella3 $ let
                  inv $ q-inverse $ quaternion 15 0 0 0
                expand-branch3 14 (quaternion 0 0 0 0) (quaternion 0 0 50 0)
                  &q* (quaternion -7.5 4 0 0) inv
                  &q* (quaternion -7.5 -2.8284 0 -4) inv
                  &q* (quaternion -7.5 -2.8284 0 4) inv
                  , 0.01
              :umbrella4 $ let
                  inv $ q-inverse $ quaternion 16 0 0 0
                expand-branch4 10 (quaternion 0 0 0 0) (quaternion 0 0 50 0)
                  &q* (quaternion -8 4 0 0) inv
                  &q* (quaternion -8 0 0 -4) inv
                  &q* (quaternion -8 -4 0 0) inv
                  &q* (quaternion -8 0 0 4) inv
                  , 0.01
              :crystal $ let
                  inv $ q-inverse $ quaternion 16 0 0 0
                expand-branch4 9 (quaternion 0 0 0 0) (quaternion 0 0 50 0)
                  &q* (quaternion -8 8 0 0) inv
                  &q* (quaternion -8 0 0 -8) inv
                  &q* (quaternion -8 -8 0 0) inv
                  &q* (quaternion -8 0 0 8) inv
                  , 0.01
              :try $ let
                  inv $ q-inverse $ quaternion 24 0 0 0
                expand-branch4 9 (quaternion 0 0 0 0) (quaternion 0 0 50 0)
                  &q* (quaternion -8 8 0 0) inv
                  &q* (quaternion -8 0 0 -8) inv
                  &q* (quaternion -8 -8 0 0) inv
                  &q* (quaternion -8 0 0 8) inv
                  , 0.01
              _ $ [] $ [] (quaternion 0 0 0 0) (quaternion 0 10 0 0)
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Tag
            :return $ :: 'List $ :: 'List 'quaternion.core/Quaternion
        'comp-fractal-tree $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn comp-fractal-tree (states)
            let
                cursor $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get states :cursor
                    , .unwrap
                  :: 'List 'Tag
                state $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                  or
                    match (get states :data)
                      (:some found) found
                      (:none) nil
                    {} $ :shape :tree
                  :: 'Map 'Tag 'Dynamic
                shape $ quatrefoil.util.core/require-decoded $ try-decode-map-as
                    get state :shape
                    , .unwrap
                  , 'Tag
              group ({})
                comp-tabs
                  {} (:selected shape)
                    :tabs $ [] :tree :cubes :umbrella3 :umbrella4 :crystal :try
                    :position $ [] -55 20 0
                  fn (tab d!)
                    d! cursor $ assoc state :shape tab
                line-segments $ {}
                  :segments $ map (build-fractal-tree shape)
                    fn (segment)
                      map segment $ fn (q)
                        match q $
                          :quaternion w x y z
                          [] x y z
                  :position $ [] 0 0 0
                  :material $ {} (:kind :line-basic) (:color 0xffb6b0) (:transparent true) (:opacity 0.4) (:linewidth 0.3)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Shape)
            :args $ [] $ :: 'Map 'Tag 'Dynamic
        'expand-branch3 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn expand-branch3 (level from v a b c minimal-seg)
            let
                branch-base v
                branch-a $ &q* v a
                branch-b $ &q* v b
                branch-c $ &q* v c
                p0 $ &q+ from branch-base
                p1 $ &q+ from branch-a
                p2 $ &q+ from branch-b
                p3 $ &q+ from branch-c
                current $ [] $ [] from p0
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                , current $ concat current
                  expand-branch3 (dec level) p0 branch-a a b c minimal-seg
                  expand-branch3 (dec level) p0 branch-b a b c minimal-seg
                  expand-branch3 (dec level) p0 branch-c a b c minimal-seg
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List $ :: 'List 'quaternion.core/Quaternion
        'expand-branch4 $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn expand-branch4 (level from v a b c d minimal-seg)
            let
                branch-base v
                branch-a $ &q* v a
                branch-b $ &q* v b
                branch-c $ &q* v c
                branch-d $ &q* v d
                p0 $ &q+ from branch-base
                p1 $ &q+ from branch-a
                p2 $ &q+ from branch-b
                p3 $ &q+ from branch-c
                p4 $ &q+ from branch-d
                current $ [] $ [] from p0
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                , current $ concat current
                  expand-branch4 (dec level) p0 branch-a a b c d minimal-seg
                  expand-branch4 (dec level) p0 branch-b a b c d minimal-seg
                  expand-branch4 (dec level) p0 branch-c a b c d minimal-seg
                  expand-branch4 (dec level) p0 branch-d a b c d minimal-seg
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] 'Number 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'quaternion.core/Quaternion 'Number
            :return $ :: 'List $ :: 'List 'quaternion.core/Quaternion
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.fractal-tree
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text line line-segments tube mesh-line
            quatrefoil.core :refer $ defcomp >> hslx
            quatrefoil.comp.control :refer $ comp-pin-point
            quatrefoil.app.materials :refer $ cover-line
            quaternion.core :refer $ v-scale v+ &v+ &q+ &q- &q* q-inverse q-length2 quaternion
            app.comp.tabs :refer $ comp-tabs
    'app.comp.tabs $ %{} 'FileEntry
      :defs $ {} $ 'comp-tabs
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-tabs (options on-change)
            let
                selected-tab $ require-decoded $ try-decode-map-as
                    get options :selected
                    , .unwrap
                  , 'Tag
                tabs $ require-decoded $ try-decode-map-as
                    get options :tabs
                    , .unwrap
                  :: 'List 'Tag
                position $ require-decoded $ try-decode-map-as
                    get options :position
                    , .unwrap
                  :: 'List 'Number
              group ({}) & $ -> tabs $ map-indexed
                fn (idx tab)
                  group
                    {} $ :position $ vector/&v-
                      vector/v3
                          nth position 0
                          , .unwrap
                        (nth position 1) .unwrap
                        (nth position 2) .unwrap
                      vector/v3 0 (* 5 idx) 0
                    box $ {} (:width 8) (:height 4) (:depth 0.4)
                      :position $ [] 0 0 0
                      :material $ {} (:kind :mesh-lambert)
                        :color $ if (= tab selected-tab) 0x555533 0x333333
                        :opacity 0.5
                        :transparent true
                      :event $ {} $ :click
                        fn (e d!)
                          hint-fn $ {}
                            :args $ [] 'Dynamic $ :: 'Fn
                              {}
                                :args $ [] 'Dynamic 'Dynamic
                                :return 'Unit
                            :return 'Unit
                          on-change tab d!
                    text $ {}
                      :text $ str tab
                      :position $ [] -4 0 1
                      :material $ {} (:kind :mesh-lambert) (:color 0xffffaa) (:opacity 0.4) (:transparent true)
                      :size 1.4
                      :depth 0.1
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'quatrefoil.schema/Component)
            :args $ [] (:: 'Map 'Tag 'Dynamic)
              :: 'Fn $ {} (:return 'Unit)
                :args $ [] 'Tag $ :: 'Fn
                  {} (:return 'Unit)
                    :args $ [] 'Dynamic 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.tabs
          :require
            quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text line tube mesh-line
            quatrefoil.core :refer $ defcomp >> hslx
            quatrefoil.comp.control :refer $ comp-pin-point
            quatrefoil.app.materials :refer $ cover-line
            quaternion.vector :as vector
            quatrefoil.util.core :refer $ require-decoded
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *store
            {} $ :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ :: 'Ref $ :: 'Map 'Tag 'Dynamic
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op op-data)
            if (list? op)
              recur :states $ [] op op-data
              let
                  store $ updater @*store
                    quatrefoil.util.core/require-decoded $ try-decode-map-as op 'Tag
                    , op-data
                ; js/console.log |Dispatch: op op-data store
                reset! *store store
                , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Dynamic 'Dynamic
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! () (load-console-formatter!) (inject-tree-methods)
            set-perspective-camera! $ {} (:fov 45) (:near 0.1) (:far 1000)
              :position $ [] 0 0 100
              :aspect $ / (quatrefoil.core/js-number js/window.innerWidth) (quatrefoil.core/js-number js/window.innerHeight)
            let
                canvas-el $ js/document.querySelector |canvas
              init-renderer! canvas-el $ {} (:background 0x110022) (:shadow-map? false)
            render-app!
            add-watch! *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            render-control!
            handle-control-events
            init-controls!
            println "|App started!"
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (non-nil? build-errors) (hud! |error build-errors)
              do (hud! |ok~ nil) (clear-cache!) (clear-control-loop!) (handle-control-events) (remove-watch! *store :changes)
                add-watch! *store :changes $ fn (store prev) (render-app!)
                render-app!
                set! js/window.onkeydown handle-key-event
                println "|Code updated."
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            |@quatrefoil/utils :refer $ inject-tree-methods
            quatrefoil.core :refer $ render-canvas! init-controls! *global-tree clear-cache! init-renderer! handle-key-event handle-control-events
            app.comp.container :refer $ comp-container
            app.updater :refer $ updater
            |three :as THREE
            touch-control.core :refer $ render-control! start-control-loop! clear-control-loop!
            |bottom-tip :default hud!
            |./calcit.build-errors :default build-errors
            quatrefoil.dsl.object3d-dom :refer $ set-perspective-camera!
    'app.updater $ %{} 'FileEntry
      :defs $ {} $ 'updater
        %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-data)
            match op
              :states $ update-states store op-data
              _ store
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'Map 'Tag 'Dynamic) 'Tag 'Dynamic
            :return $ :: 'Map 'Tag 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ quatrefoil.cursor :refer $ update-states
