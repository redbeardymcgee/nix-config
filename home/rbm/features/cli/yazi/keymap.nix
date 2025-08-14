{
  select = {
    prepend_keymap = [
      {
        on = ["q"];
        run = "close";
        desc = "Cancel selection";
      }
    ];
  };

  mgr = {
    prepend_keymap = [
      # Nav
      {
        on = ["j"];
        run = "plugin augment-command -- arrow 1";
        desc = "Move cursor up";
      }

      {
        on = ["k"];
        run = "plugin augment-command -- arrow -1";
        desc = "Move cursor up";
      }

      {
        on = ["J"];
        run = "plugin augment-command -- parent_arrow 1";
        desc = "Move cursor up in parent directory";
      }

      {
        on = ["K"];
        run = "plugin augment-command -- parent_arrow -1";
        desc = "Move cursor down in parent directory";
      }

      {
        on = ["l"];
        run = "plugin augment-command -- enter";
        desc = "Enter a directory and skip directories with only a single subdirectory";
      }

      {
        on = ["L"];
        run = "plugin augment-command -- enter --no-skip";
        desc = "Enter the child directory or open the file";
      }

      {
        on = ["<Enter>"];
        run = "plugin augment-command -- enter";
        desc = "Enter a directory and skip directories with only a single subdirectory";
      }

      {
        on = ["<S-Enter>"];
        run = "plugin augment-command -- enter --no-skip";
        desc = "Enter the child directory or open the file";
      }

      {
        on = ["h"];
        run = "plugin augment-command -- leave";
        desc = "Leave a directory and skip directories with only a single subdirectory";
      }

      {
        on = ["H"];
        run = "plugin augment-command -- leave --no-skip";
        desc = "Go back to the parent directory";
      }

      # Search & jump
      {
        on = ["F"];
        run = "plugin smart-filter";
        desc = "Smart filter";
      }

      {
        on = ["f" "s"];
        run = "plugin searchjump";
        desc = "Jump by label";
      }

      # {
      #   on = ["f" "g"];
      #   run = "plugin fg --args='rg'";
      #   desc = "Find file by grep";
      # }

      # {
      #   on = ["f" "f"];
      #   run = "plugin fg --args='fzf'";
      #   desc = "Find file by name";
      # }

      # Bookmarks
      {
        on = ["b" "a"];
        run = "plugin yamb --args=save";
        desc = "Add bookmark";
      }

      {
        on = ["b" "b"];
        run = "plugin yamb --args=jump_by_fzf";
        desc = "Jump to a bookmark by fzf";
      }

      {
        on = ["b" "d"];
        run = "plugin yamb --args=delete_by_fzf";
        desc = "Delete a bookmark by fzf";
      }

      {
        on = ["b" "r"];
        run = "plugin yamb --args=rename_by_fzf";
        desc = "Rename a bookmark by fzf";
      }

      # Rename
      {
        on = ["r" "r"];
        run = "plugin augment-command -- rename --cursor=before_ext";
        desc = "Rename a file or directory";
      }

      {
        on = ["r" "R"];
        run = "plugin augment-command -- rename --empty=all";
        desc = "Rename file and remove the whole file name";
      }

      {
        on = ["r" "i"];
        run = "plugin augment-command -- rename --cursor=start";
        desc = "Rename file at the start of the file name";
      }

      {
        on = ["r" "a"];
        run = "plugin augment-command -- rename --cursor=end";
        desc = "Rename file with the cursor at the end of the file name";
      }

      # Yank & Paste
      {
        on = ["p"];
        run = "plugin augment-command -- paste";
        desc = "Paste the files";
      }

      {
        on = ["P"];
        run = "plugin augment-command -- paste --force";
        desc = "Paste the files (overwrite if the destination exists)";
      }

      {
        on = ["u"];
        run = ["select_all --state=false" "unyank"];
        desc = "Unselect all files and also unyank cut files";
      }

      {
        on = ["y"];
        run = [ /* ''shell 'cb copy "$@"' --confirm'' */ "yank"];
        desc = "Yank file";
      }

      # Create & Delete
      {
        on = ["d"];
        run = "plugin augment-command -- remove";
        desc = "Move the files to the trash";
      }

      # Open
      {
        on = ["o"];
        run = "plugin augment-command -- open";
        desc = "Open selected files interactively";
      }

      {
        on = ["O"];
        run = "plugin augment-command -- open --interactive";
        desc = "Open selected files interactively";
      }

      # Tools
      {
        on = ["t" "e"];
        run = "plugin augment-command -- editor";
        desc = "Open '$EDITOR' on selected files";
      }

      {
        on = ["t" "g"];
        run = "plugin lazygit";
        desc = "Lazygit";
      }

      {
        on = ["t" "p"];
        run = "plugin augment-command -- pager";
        desc = "Open '$PAGER' on selected files";
      }

      {
        on = ["t" "s"];
        run = ''
          plugin augment-command -- shell "$SHELL" --confirm --block
        '';
        desc = "Open shell here";
      }

      {
        on = ["t" "d"];
        run = ''
          plugin augment-command -- shell ripdrag "$@" -x 2>/dev/null & --confirm
        '';
        desc = "Drag and drop into the hovered directory or CWD";
      }

      {
        on = ["t" "m"];
        run = "plugin chmod";
        desc = "Chmod on selected files";
      }

      {
        on = ["t" "d"];
        run = "plugin diff";
        desc = "Diff the selected with the hovered file";
      }

      {
        on = ["t" "c"];
        run = "plugin ouch --args=zip";
        desc = "Compress with ouch";
      }
    ];
  };

  opener = {
    extract = [
      {
        run = ''ouch d -y "$@"'';
        for = "unix";
      }
    ];
  };
}
