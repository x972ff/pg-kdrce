# neutralized PoC artifact — the require-exec vector is demonstrated by this file merely loading.
module Kramdown; module Parser; class Evil; def initialize(*a); end; def parse; end; end; end; end
