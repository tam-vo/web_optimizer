module WebOptimizer
  module Common
    def check_include_dir(ignore_dirs, child_path)
      ignore_dirs.each do |ignore_dir|
        return true unless child_path.match(/^#{ignore_dir}\/?/).nil?
      end

      false
    end
  end
end

