module SensuPluginsCpuChecks
  module CommonInterrupts
    def build_regexp(line)
      regexp_string = '[[:space:]]*(?<irq_number>.+):'
      cpu_list = line.scan(/CPU\d+/)
      cpu_list.each do |name|
        regexp_string += "[[:space:]]*(?<#{name}>\\d+)"
      end
      regexp_string += '[[:space:]]*(?<irq_type>.*)'
      [Regexp.new(regexp_string), cpu_list]
    end

    def output_metrics(filename)
      regexp = nil
      cpu_list = []
      File.open("#{config[:proc_path]}/#{filename}", 'r').each_line.with_index do |line, index|
        if index.zero?
          regexp, cpu_list = build_regexp(line)
        else
          result = line.match(regexp)
          if result
            cpu_list.each do |name|
              key = [config[:scheme], name, result[:irq_type].split.join('-'), result[:irq_number]].reject(&:empty?)
              output key.join('.').to_s, result[name]
            end
          end
        end
      end
    end
  end
end
