class LatexToPdf
  def self.generate_pdf(code,config,parse_twice=nil)
    config=self.config.merge(config)
    parse_twice=config[:parse_twice] if parse_twice.nil?
    dir=File.join(Rails.root,'tmp','rails-latex',"#{Process.pid}-#{Thread.current.hash}")
    input=File.join(dir,'input.tex')
    FileUtils.mkdir_p(dir)
    File.open(input,'wb') {|io| io.write(code) }
    Process.waitpid(
      fork do
        begin
          Dir.chdir dir
          STDOUT.reopen("input.log","a")
          STDERR.reopen(STDOUT)
          args=config[:arguments] + %w[-shell-escape -interaction batchmode input.tex]
          system config[:command],'-draftmode',*args if parse_twice
          exec config[:command],*args
        rescue
          File.open("input.log",'a') {|io|
            io.write("#{$!.message}:\n#{$!.backtrace.join("\n")}\n")
          }
        ensure
          Process.exit! 1
        end
      end)
    if File.exist?(pdf_file=input.sub(/\.tex$/,'.pdf'))
      FileUtils.mv(input.sub(/\.tex$/,'.log'),File.join(dir,'..','input.log'))
      result=File.read(pdf_file)
      FileUtils.rm_rf(dir)
    else
      # raise "pdflatex failed: See #{input.sub(/\.tex$/,'.log')} for details"
      raise File.open("#{input.sub(/\.tex$/,'.log')}", "r").read
    end
    result
  end
end
