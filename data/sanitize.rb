file = 'image_names.txt'
sanitized = 'sanitized_names.txt'
f = File.open(file, "r")
s = File.open(sanitized, 'w')

def sanitize(name)
  name.gsub(/,jpg$/i, '')
  name.gsub(/,png$/i, '')
  name.gsub(/\(\d{1,3}\)/, '')
  name.gsub(/[^0-9A-Z -]/i, '_')
  name.strip
end

def get_token(name)
  end_token = name.split.last.to_i
  start_token = name.split.first.to_i
  end_token || start_token
end

f.each_line { |line|
  line = sanitize(line)
  token = get_token(line)
  s.write("Token: #{token}. #{line}\n")
}
f.close
