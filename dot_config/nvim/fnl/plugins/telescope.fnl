(import-macros {:mixed-table · : recc} :toast.macros)

(fn gen [key fun desc]
  (· (.. :<leader>f key) #(recc :telescope.builtin fun) & :desc desc))

[(· :nvim-telescope/telescope.nvim &
    :dependencies [:nvim-lua/plenary.nvim
                   (· :nvim-telescope/telescope-fzf-native.nvim &
                      :build :make)]
    :config (fn [_ opts]
             (let [ts (require :telescope)]
              (ts.setup opts)
              (ts.load_extension :fzf)))
    :cmd :Telescope
    :keys [(gen :f :find_files "Find File")
           (gen :g :live_grep  "Live Grep")
           (gen :b :buffers    "Find Buffer")
           (gen :h :help_tags  "Find Help")
           (gen :c :commands   "Find Command")
           (gen :t :treesitter "Find Treesitter")])]
