require 'rubygems'
require 'benchmark'
require 'yaml'
require 'zaml'
require 'json'

TIMES=1000
src_small = [{:source_room_spec=>{:adults=>4, :children_ages=>[]}, :hotel_code=>"11206", :rate_plan_code=>"DISC", :room_type_code=>"PRS", :rates=>[{:base_price=>{:amount_before_tax=>"2175.00", :amount_after_tax=>"2855.00", :currency_code=>"EUR"}, :total_price=>{:amount_before_tax=>"15225.00", :amount_after_tax=>"19985.00", :currency_code=>"EUR"}, :rate_by_night=>[{:date=>"4/26/2012", :price=>"2175.00", :tax=>"605.00", :fee=>"75.00", :full_price=>"2855.00"}, {:date=>"4/27/2012", :price=>"2175.00", :tax=>"605.00", :fee=>"75.00", :full_price=>"2855.00"}, {:date=>"4/28/2012", :price=>"2175.00", :tax=>"605.00", :fee=>"75.00", :full_price=>"2855.00"}, {:date=>"4/29/2012", :price=>"2175.00", :tax=>"605.00", :fee=>"75.00", :full_price=>"2855.00"}, {:date=>"4/30/2012", :price=>"2175.00", :tax=>"605.00", :fee=>"75.00", :full_price=>"2855.00"}, {:date=>"5/1/2012", :price=>"2175.00", :tax=>"605.00", :fee=>"75.00", :full_price=>"2855.00"}, {:date=>"5/2/2012", :price=>"2175.00", :tax=>"605.00", :fee=>"75.00", :full_price=>"2855.00"}]}]}]
src_big = src_small * 1000

src_yaml_small=src_small.to_yaml
src_yaml_big=src_big.to_yaml

src_json_small=src_small.to_json
src_json_big=src_big.to_json

src_bin_small=Marshal.dump(src_small)
src_bin_big=Marshal.dump(src_big)

#src_xml_small=src.to_xml
#src_xml_big=src_big.to_xml
out=""
TIMES=50
Benchmark.bm(7) do |x|
  x.report(".to_yaml small:")   { TIMES.times {out = src_small.to_yaml} ; puts(out.length); }
  x.report(".to_yaml big:") { TIMES.times {out = src_big.to_yaml} ; puts(out.length);}
  x.report("ZAML dump small:")   { TIMES.times {out =  ZAML.dump(src_yaml_small)} ; puts(out.length);}
  x.report("ZAML dump big:") { TIMES.times {out = ZAML.dump(src_yaml_big)} ; puts(out.length);}
  x.report(".to_json small:")   { TIMES.times {out =  src_small.to_json} ; puts(out.length);}
  x.report(".to_json big:") { TIMES.times {out = src_big.to_json} ; puts(out.length);}
  x.report("bin marshal small:")   { TIMES.times {out = Marshal.dump(src_small)} ; puts(out.length);}
  x.report("bin marshal big:") { TIMES.times {out = Marshal.dump(src_big)} ; puts(out.length);}

  x.report("YAML load small:")   { TIMES.times {out = YAML.load(src_yaml_small)} ; puts(out.length);}
  x.report("YAML load big:") { TIMES.times {out = YAML.load(src_yaml_big)} ; puts(out.length);}
  # ZAML is for serialization only
  x.report("JSON load small:")   { TIMES.times {out = JSON.parse(src_json_small)} ; puts(out.length);}
  x.report("JSON load big:") { TIMES.times {out = JSON.parse(src_json_big)} ; puts(out.length);}
  x.report("bin marshal small:")   { TIMES.times {out = Marshal.load(src_bin_small)} ; puts(out.length);}
  x.report("bin marshal big:") { TIMES.times {out = Marshal.load(src_bin_big)} ; puts(out.length);}
end