(let [starter (require :mini.starter)
      telescope [{:action "Telescope commands"
                  :name :Commands}
                 {:action "Telescope find_files"
                  :name :Files}
                 {:action "Telescope help_tags"
                  :name "Help tags"}
                 {:action "Telescope live_grep"
                  :name "Live grep"}
                 {:action "Telescope oldfiles"
                  :name "Old files"}]]
  (each [_ v (ipairs telescope)]
   (set v.section :Telescope))
  {:items [telescope
           (starter.sections.builtin_actions)]})
