module Idn
  VERSION = "0.1.0"

  IDNA_ALLOW_UNASSIGNED = 0x0001      # Don't reject strings containing unassigned Unicode code points.
  IDNA_USE_STD3_ASCII_RULES = 0x0002  # Validate strings according to STD3 rules (i.e., normal host name rules).

  @[Link("idn")]
  lib Lib
    fun idna_to_ascii_8z(UInt8*, Pointer(UInt8*), Int32) : Int32
    fun idna_to_unicode_8z8z(UInt8*, Pointer(UInt8*), Int32) : Int32
  end

  class Error < Exception; end

  macro transform(method, lib_method)
    def self.to_{{ method.id }}(s : String, flags = IDNA_ALLOW_UNASSIGNED)
      res = Lib.{{ lib_method.id }}(s, out pointer, flags)
      if res != 0
        raise Error.new("bad answer from libidn: #{res}, http://www.gnu.org/software/libidn/reference/libidn-idna.html#IDNA-SUCCESS:CAPS")
      end
      String.new(pointer).tap { LibC.free(pointer as Void*) }
    end
  end

  transform :ascii, :idna_to_ascii_8z
  transform :unicode, :idna_to_unicode_8z8z
end
