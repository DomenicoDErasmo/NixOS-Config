{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  # Nixvim
  programs.nixvim = {
    enable = true;

    options = {
      number = true;
      relativenumber = true;
    };

    plugins = {
      # Builtin LSP
      lsp = {
        enable = true;
        servers = {
          # Rust
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            settings = {
              checkOnSave = true;
              check = {
                command = "clippy";
                extraArgs = [
                  "--"
                  # "-D"
                  # "clippy::correctness"
                  # "-D"
                  # "clippy::pedantic"
                  # "-D"
                  # "clippy::nursery"
                  # "-D"
                  # "clippy::perf"
                  # "-D"
                  # "clippy::suspicious"
                  # "-D"
                  # "clippy::style"
                  # "-D"
                  # "clippy::complexity"
                  # "-D"
                  # "clippy::cargo"
                  # "-D"
                  # "clippy::absolute_paths"
                  # "-D"
                  # "clippy::alloc_instead_of_core"
                  # "-D"
                  # "clippy::arithmetic_side_effects"
                  # "-D"
                  # "clippy::as_underscore "
                  # "-D"
                  # "clippy::assertions_on_result_states"
                  # "-D"
                  # "clippy::clone_on_ref_ptr"
                  # "-D"
                  # "clippy::create_dir"
                  # "-D"
                  # "clippy::decimal_literal_representation"
                  # "-D"
                  # "clippy::default_numeric_fallback"
                  # "-D"
                  # "clippy::default_union_representation"
                  # "-D"
                  # "clippy::disallowed_script_idents"
                  # "-D"
                  # "clippy::else_if_without_else"
                  # "-D"
                  # "clippy::empty_drop"
                  # "-D"
                  # "clippy::empty_structs_with_brackets"
                  # "-D"
                  # "clippy::error_impl_error"
                  # "-D"
                  # "clippy::exit"
                  # "-D"
                  # "clippy::expect_used"
                  # "-D"
                  # "clippy::filetype_is_file"
                  # "-D"
                  # "clippy::float_arithmetic"
                  # "-D"
                  # "clippy::float_cmp_const"
                  # "-D"
                  # "clippy::fn_to_numeric_cast_any"
                  # "-D"
                  # "clippy::format_push_string"
                  # "-D"
                  # "clippy::get_unwrap"
                  # "-D"
                  # "clippy::host_endian_bytes"
                  # "-D"
                  # "clippy::if_then_some_else_none"
                  # "-D"
                  # "clippy::impl_trait_in_params"
                  # "-D"
                  # "clippy::indexing_slicing"
                  # "-D"
                  # "clippy::infinite_loop"
                  # "-D"
                  # "clippy::integer_division"
                  # "-D"
                  # "clippy::iter_over_hash_type"
                  # "-D"
                  # "clippy::large_include_file"
                  # "-D"
                  # "clippy::let_underscore_must_use"
                  # "-D"
                  # "clippy::let_underscore_untyped"
                  # "-D"
                  # "clippy::little_endian_bytes"
                  # "-D"
                  # "clippy::lossy_float_literal"
                  # "-D"
                  # "clippy::map_err_ignore"
                  # "-D"
                  # "clippy::mem_forget"
                  # "-D"
                  # "clippy::min_ident_chars"
                  # "-D"
                  # "clippy::missing_assert_message"
                  # "-D"
                  # "clippy::missing_asserts_for_indexing"
                  # "-D"
                  # "clippy::missing_docs_in_private_items"
                  "-D"
                  "clippy::missing_inline_in_public_items"
                  # "-D"
                  # "clippy::missing_trait_methods"
                  # "-D"
                  # "clippy::mixed_read_write_in_expression"
                  # "-D"
                  # "clippy::mod_module_files"
                  # "-D"
                  # "clippy::modulo_arithmetic"
                  # "-D"
                  # "clippy::multiple_inherent_impl"
                  # "-D"
                  # "clippy::multiple_unsafe_ops_per_block"
                  # "-D"
                  # "clippy::mutex_atomic"
                  # "-D"
                  # "clippy::needless_raw_strings"
                  # "-D"
                  # "clippy::non_ascii_literal"
                  # "-D"
                  # "clippy::panic"
                  # "-D"
                  # "clippy::panic_in_result_fn"
                  # "-D"
                  # "clippy::partial_pub_fields"
                  # "-D"
                  # "clippy::pattern_type_mismatch"
                  # "-D"
                  # "clippy::pub_use"
                  # "-D"
                  # "clippy::pub_with_shorthand"
                  # "-D"
                  # "clippy::rc_buffer"
                  # "-D"
                  # "clippy::rc_mutex"
                  # "-D"
                  # "clippy::redundant_type_annotations"
                  # "-D"
                  # "clippy::rest_pat_in_fully_bound_structs"
                  # "-D"
                  # "clippy::same_name_method"
                  # "-D"
                  # "clippy::semicolon_inside_block"
                  # "-D"
                  # "clippy::shadow_reuse"
                  # "-D"
                  # "clippy::shadow_same"
                  # "-D"
                  # "clippy::shadow_unrelated"
                  # "-D"
                  # "clippy::single_char_lifetime_names"
                  # "-D"
                  # "clippy::std_instead_of_alloc"
                  # "-D"
                  # "clippy::std_instead_of_core"
                  # "-D"
                  # "clippy::str_to_string"
                  # "-D"
                  # "clippy::string_add"
                  # "-D"
                  # "clippy::string_lit_chars_any"
                  # "-D"
                  # "clippy::string_slice"
                  # "-D"
                  # "clippy::string_to_string"
                  # "-D"
                  # "clippy::suspicious_xor_used_as_pow"
                  # "-D"
                  # "clippy::tests_outside_test_module"
                  # "-D"
                  # "clippy::todo"
                  # "-D"
                  # "clippy::try_err"
                  # "-D"
                  # "clippy::undocumented_unsafe_blocks"
                  # "-D"
                  # "clippy::unimplemented"
                  # "-D"
                  # "clippy::unnecessary_safety_comment"
                  # "-D"
                  # "clippy::unnecessary_safety_doc"
                  # "-D"
                  # "clippy::unnecessary_self_imports"
                  # "-D"
                  # "clippy::unneeded_field_pattern"
                  # "-D"
                  # "clippy::unreachable"
                  # "-D"
                  # "clippy::unseparated_literal_suffix"
                  # "-D"
                  # "clippy::unwrap_in_result"
                  # "-D"
                  # "clippy::unwrap_used"
                  # "-D"
                  # "clippy::verbose_file_reads"
                  # "-D"
                  # "clippy::wildcard_enum_match_arm"
                ];
              };
            };
          };
          # Nix
          nil_ls = {
            enable = true;
          };
        };
      };
      # LSP Lines
      lsp-lines = {
        enable = true;
      };
      # Fugitive - Git wrapper
      fugitive = {
        enable = true;
      };
      # Airline - Status bar
      airline = {
        enable = true;
      };
    };
  };
}