require "json"
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "rpgtables/rtable.rb"

json = File.read("data/TestTable_rpgtable.json")
obj = JSON.parse(json)

@table = RTable.new
@table.set_name(obj["name"])
@table.table = obj["table"]
@table.dice = obj["dice"]
@table.calculate_table
File.open("export/TestTable.txt", "w") do |f|
  5.times.each do
    f.write("\n")
  end
  f.write(" " * 20 + "|" + "-" * 56 + "|\n")
  f.write(" " * 20 + "|" + " " * 56 + "|\n")
  f.write(" " * 20 + "|" + @table.name.center(56) + "|\n")
  f.write(" " * 20 + "|" + " " * 56 + "|\n")
  f.write(" " * 20 + "|" + "-" * 56 + "|\n")
  f.write(" " * 20 + "|" + "Roll".center(7) + "|" + "Chance".center(8) + "|" +
          "Entry".center(39) + "|\n")
  f.write(" " * 20 + "|" + "-" * 56 + "|\n")
  i = 0
  @table.table.each do |d|
    d.each do |e|
      f.write(" " * 20 + "| " + "#{i + @table.dice.count}".center(6) + "| " +
              "#{'%.2f' % @table.percent_array[i]}%".ljust(7) + "| " +
              "#{e}".ljust(38) + "|\n")
      f.write(" " * 20 + "|" + "-" * 56 + "|\n")
      i += 1
    end
  end
end
