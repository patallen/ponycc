
primitive _ASTUtil
  fun parse_lit_integer(pos: SourcePosAny): U128 ? =>
    pos.string().u128()?

  fun parse_lit_float(pos: SourcePosAny): F64 ? =>
    // TODO: fix stdlib String.f64 to error on failure.
    if pos.length() == 0 then error end
    pos.string().f64()?

  fun parse_lit_string(pos: SourcePosAny): String ? =>
    let quotes_length =
      if pos.string().at("\"\"\"")
      then USize(3)
      else USize(1)
      end

    if pos.length() < (2 * quotes_length) then error end

    // TODO: handle escaped characters
    SourcePos(pos.source(), pos.offset() + quotes_length, pos.length() - (2 * quotes_length)).string()

  fun parse_lit_character(pos: SourcePosAny): U8 ? =>
    // TODO: handle escaped characters
    if pos.length() != 3 then error end
    SourcePos(pos.source(), pos.offset() + 1, pos.length() - 2).string()(0)?

  fun parse_id(pos: SourcePosAny): String ? =>
    if pos.length() == 0 then error end
    pos.string()
