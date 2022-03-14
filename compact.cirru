
{} (:package |app)
  :configs $ {} (:init-fn |app.main/main!) (:reload-fn |app.main/reload!)
    :modules $ [] |touch-control/ |pointed-prompt/ |quatrefoil/
    :version |0.0.4
  :entries $ {}
  :files $ {}
    |app.comp.container $ {}
      :ns $ quote
        ns app.comp.container $ :require
          quatrefoil.alias :refer $ group box sphere point-light ambient-light perspective-camera scene text line tube mesh-line
          quatrefoil.core :refer $ defcomp >> hslx
          quatrefoil.comp.control :refer $ comp-pin-point
          quatrefoil.app.materials :refer $ cover-line
          quatrefoil.math :refer $ v-scale v+ &v+ &q+ &q- &q* q-inverse q-length2
      :defs $ {}
        |comp-container $ quote
          defcomp comp-container (store)
            let
                states $ :states store
                cursor $ :cursor states
                state $ either (:data states)
                  {} $ :tab :ruled-surface
              scene ({})
                perspective-camera $ {} (:fov 45)
                  :aspect $ / js/window.innerWidth js/window.innerHeight
                  :near 0.1
                  :far 1000
                  :position $ [] 0 0 100
                comp-tabs (:tab state)
                  fn (tab d!)
                    d! cursor $ assoc state :tab tab
                case-default (:tab state)
                  text $ {}
                    :text $ str "\"Unknown tab " (:tab state)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :mesh-lambert) (:color 0xffff33) (:opacity 1)
                    :size 2
                    :height 0.5
                  :ruled-surface $ comp-ruled-surface (>> states :ruled)
                  :fractal $ comp-fractal
                group
                  {} $ :position ([] -10 0 20)
                  point-light $ {} (:color 0xffff33) (:intensity 2) (:distance 100)
                  sphere $ {} (:radius 0.6) (:width-segments 10) (:height-segments 10)
                    :material $ {} (:kind :mesh-lambert) (:color 0xffff33) (:opacity 1)
                ambient-light $ {} (:color 0xffff00) (:intensity 1)
                ; point-light $ {} (:color 0xffffff) (:intensity 1.4) (:distance 200)
                  :position $ [] 20 40 50
                ; point-light $ {} (:color 0xffffff) (:intensity 2) (:distance 200)
                  :position $ [] 0 60 0
        |&v- $ quote
          defn &v- (a b)
            let[] (x y z) a $ let[] (x2 y2 z2) b
              [] (- x x2) (- y y2) (- z z2)
        |comp-ruled-surface $ quote
          defcomp comp-ruled-surface (states)
            let
                cursor $ :cursor states
                state $ or (:data states)
                  {}
                    :s0 $ [] 0 0 0
                    :s1 $ [] 10 0 0
                    :e0 $ [] 0 10 1
                    :e1 $ [] 10 10 1
                step 40
                v0 $ v-scale
                  &v- (:e0 state) (:s0 state)
                  / 1 step
                v1 $ v-scale
                  &v- (:e1 state) (:s1 state)
                  / 1 step
              group ({})
                comp-pin-point
                  {}
                    :position $ :s0 state
                    :speed 0.1
                    :color 0xffffaa
                  fn (p d!)
                    d! cursor $ assoc state :s0 p
                comp-pin-point
                  {}
                    :position $ :s1 state
                    :speed 0.1
                    :color 0xffffaa
                  fn (p d!)
                    d! cursor $ assoc state :s1 p
                comp-pin-point
                  {}
                    :position $ :e0 state
                    :speed 0.1
                    :color 0xffffaa
                  fn (p d!)
                    d! cursor $ assoc state :e0 p
                comp-pin-point
                  {}
                    :position $ :e1 state
                    :speed 0.1
                    :color 0xffffaa
                  fn (p d!)
                    d! cursor $ assoc state :e1 p
                line $ {}
                  :points $ [] (:s0 state) (:e0 state)
                  :position $ [] 0 0 0
                  :material $ assoc cover-line :opacity 0.5
                line $ {}
                  :points $ [] (:s1 state) (:e1 state)
                  :position $ [] 0 0 0
                  :material $ assoc cover-line :opacity 0.5
                group ({}) & $ ->
                  range $ inc step
                  map $ fn (idx)
                    mesh-line $ {}
                      :points $ []
                        &v+ (:s0 state) (v-scale v0 idx)
                        &v+ (:s1 state) (v-scale v1 idx)
                      :position $ [] 0 0 0
                      :material $ {} (:kind :mesh-line)
                        :color $ hslx
                          * 360 $ js/Math.random
                          , 100 80
                        :transparent true
                        :opacity 0.9
                        :lineWidth 0.4
        |comp-tabs $ quote
          defcomp comp-tabs (selected-tab on-change)
            group ({}) & $ -> ([] :ruled-surface :fractal)
              map-indexed $ fn (idx tab)
                group
                  {} $ :position
                    [] -40 (* 10 idx) 0
                  box $ {} (:width 10) (:height 5) (:depth 1)
                    :position $ [] 0 0 0
                    :material $ {} (:kind :mesh-lambert)
                      :color $ if (= tab selected-tab) 0x555533 0x333333
                      :opacity 1
                    :event $ {}
                      :click $ fn (e d!) (on-change tab d!)
                  text $ {}
                    :text $ str tab
                    :position $ [] 0 0 1
                    :material $ {} (:kind :mesh-lambert) (:color 0xffffaa) (:opacity 1)
                    :size 2
                    :height 0.5
        |comp-fractal $ quote
          defn comp-fractal () $ line
            {}
              :points $ fold-line 10 ([] 0 0 0 0) ([] 100 0 0 0) ([] 15 0 0 10) ([] 0 15 0 20) ([] 0 0 15 30)
                q-inverse $ [] 0 0 0 40
              :position $ [] 5 -10 0
              :material $ {} (:kind :mesh-line) (:color 0xffffaa) (:transparent true) (:opacity 0.4) (:lineWidth 0.1)
        |fold-line $ quote
          defn fold-line (level base v a b c full')
            let
                branch-a $ &q* (&q* v full') a
                branch-b $ &q* (&q* v full') b
                branch-c $ &q* (&q* v full') c
              if
                or (<= level 0)
                  &< (q-length2 v) minimal-seg
                [] (&q+ base branch-a) (&q+ base branch-b) (&q+ base v)
                concat
                  fold-line (dec level) base branch-a a b c full'
                  fold-line (dec level) (&q+ base branch-a) (&q- branch-b branch-a) a b c full'
                  fold-line (dec level) (&q+ base branch-b) (&q- branch-c branch-b) a b c full'
                  fold-line (dec level) (&q+ base branch-c) (&q- v branch-c) a b c full'
        |minimal-seg $ quote
          def minimal-seg $ js/parseFloat
            either (get-env "\"minimal-seg") "\"0.08"
    |app.updater $ {}
      :ns $ quote
        ns app.updater $ :require
          quatrefoil.cursor :refer $ update-states
      :defs $ {}
        |updater $ quote
          defn updater (store op op-data)
            case-default op store $ :states (update-states store op-data)
    |app.main $ {}
      :ns $ quote
        ns app.main $ :require
          "\"@quamolit/quatrefoil-utils" :refer $ inject-tree-methods
          quatrefoil.core :refer $ render-canvas! *global-tree clear-cache! init-renderer! handle-key-event handle-control-events
          app.comp.container :refer $ comp-container
          app.updater :refer $ [] updater
          "\"three" :as THREE
          touch-control.core :refer $ render-control! control-states start-control-loop! clear-control-loop!
          "\"mobile-detect" :default mobile-detect
          "\"bottom-tip" :default hud!
          "\"./calcit.build-errors" :default build-errors
      :defs $ {}
        |render-app! $ quote
          defn render-app! () (; println "|Render app:")
            render-canvas! (comp-container @*store) dispatch!
        |main! $ quote
          defn main! () (load-console-formatter!) (inject-tree-methods)
            let
                canvas-el $ js/document.querySelector |canvas
              init-renderer! canvas-el $ {} (:background 0x110022)
            render-app!
            add-watch *store :changes $ fn (store prev) (render-app!)
            set! js/window.onkeydown handle-key-event
            when mobile? (render-control!) (handle-control-events)
            println "|App started!"
        |*store $ quote
          defatom *store $ {}
            :states $ {}
              :cursor $ []
        |dispatch! $ quote
          defn dispatch! (op op-data)
            if (list? op)
              recur :states $ [] op op-data
              let
                  store $ updater @*store op op-data
                ; js/console.log |Dispatch: op op-data store
                reset! *store store
        |reload! $ quote
          defn reload! () $ if (some? build-errors) (hud! "\"error" build-errors)
            do (hud! "\"ok~" nil) (clear-cache!)
              when mobile? (clear-control-loop!) (handle-control-events)
              remove-watch *store :changes
              add-watch *store :changes $ fn (store prev) (render-app!)
              render-app!
              set! js/window.onkeydown handle-key-event
              println "|Code updated."
        |mobile? $ quote
          def mobile? $ .!mobile (new mobile-detect js/window.navigator.userAgent)
