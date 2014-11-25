# coding: sjis
#########################################################
###place the file on the directory includes TEX-Genkou###
#########################################################

require 'fileutils'

#大学基本設定
print "国立大なら1を、私立大なら2を入力"
is_kokuritsu = gets.chomp.to_i
case is_kokuritsu
when 1
	ritsu = "kokuritsu"
when 2
	ritsu = "shiritsu"
end

print "大学名をローマ字12字以内で入力"
univ_name = gets.chomp.capitalize!

print "大学略称をローマ字で入力"
univ_short_name = gets.chomp.upcase!

#学部設定
print "単学部なら1を、そうでないなら2を入力"
has_only_college = gets.chomp.to_i
if has_only_college == 1
	print "前期なら1、中期なら2、後期なら3、医学部のみなら4を入力"
	college_option = gets.chomp.to_i
	case college_option
	when 1
		college_name = "zen"
	when 2 
		college_name = "chu"
	when 3
		college_name = "kou"
	when 4
		college_name = "i"
	end
elsif has_only_college == 2
	print "学部名を10字以内のローマ字で入力\n\
	学科名は-で繋ぐこと\n(例：ri-oubutsu)"
	college_name = gets.chomp.downcase
end

#問題設定
##parts = 大問 question = 小問
print "大問数を入力"
numbers_of_parts = gets.chomp.to_i
numbers_of_questions = Array.new(numbers_of_parts + 1)
for i in 1..numbers_of_parts do
	print "小問数を入力(ない場合は0を入力)"
	numbers_of_questions[i] = gets.chomp.to_i
end

#フォルダ名セット
univ_folder_path = File.expand_path("../TEX-Genkou/14-Nyushi/14-#{ritsu}/14-#{univ_name}", __FILE__)
univ_college_folder_name = "14-#{univ_short_name}-#{college_name}"
college_folder_path = "#{univ_folder_path}/#{univ_college_folder_name}"
##フォルダ名の語幹部と活用語尾部を別にセッティング
suffixes_of_folders = Array.new()
for i in 1..numbers_of_parts do
	if numbers_of_questions[i] == 0
		suffixes_of_folders << i.to_s
	else
		for j in 1..numbers_of_questions[i] do
			suffixes_of_folders << "#{i.to_s}-#{j.to_s}"
		end
	end
end
suffixes_of_folders << "end" << "matome"

#フォルダ実作成
FileUtils::mkdir_p(college_folder_path)
suffixes_of_folders.each{|suffix|
    FileUtils::mkdir_p("#{college_folder_path}/#{univ_college_folder_name}-#{suffix}")
}
