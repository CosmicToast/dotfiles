(import-macros {: tbl : recc} :toast.macros)

(fn gen [key fun desc]
  (tbl (.. :<leader>f key) #(recc :telescope.builtin fun) & :desc desc))

[(tbl :nvim-telescope/telescope.nvim &
      :dependencies [:nvim-lua/plenary.nvim
                     (tbl :nvim-telescope/telescope-fzf-native.nvim &
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
