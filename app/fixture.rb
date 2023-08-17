# frozen_string_literal: true

require 'oj'

# TODO: add unit spec

Fixture = Data.define(:variant, :data, :expected) do
  def self.load!(path)
    sample_path = File.join(path, 'sample.html')
    expected_path = File.join(path, 'expected-array.json')

    raise Errors::FileNotFound, "sample file not found: #{sample_path}" unless File.exist?(sample_path)
    raise Errors::FileNotFound, "expected file not found: #{expected_path}" unless File.exist?(expected_path)

    Fixture.new(
      variant: path,
      data: read_file(sample_path),
      expected: read_file(expected_path).then { |data| Oj.load(data) }
    )
  end

  def self.read_file(path)
    File.read(path, mode: 'r', encoding: 'utf-8')
  end

  def inspect
    "#<#{self.class} variant=#{variant}} data=#{data.length}"
  end
end
