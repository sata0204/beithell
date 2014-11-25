# coding: sjis
################
#place the file on the directory includes TEX-Genkou
################

require 'fileutils'

#大学基本設定
print "国立大なら1を、私立大なら2を入力"
isKokuritsu = gets.chomp.to_i
case isKokuritsu
when 1
	ritsu = "kokuritsu"
when 2
	ritsu = "shiritsu"
end

print "大学名をローマ字12字以内で入力"
univName = gets.chomp.capitalize!
print "大学略称をローマ字で入力"
univShortName = gets.chomp.upcase!

#学部設定
print "単学部なら1を、そうでないなら2を入力"
hasOnlyCollege = gets.chomp.to_i
if hasOnlyCollege == 1
	print "前期なら1、中期なら2、後期なら3、医学部のみなら4を入力"
	collegeOption = gets.chomp.to_i
	case collegeOption
	when 1
		collegeName = "zen"
	when 2 
		collegeName = "chu"
	when 3
		collegeName = "kou"
	when 4
		collegeName = "i"
	end
elsif hasOnlyCollege == 2
	print "学部名を10字以内のローマ字で入力\n\
	学科名は-で繋ぐこと\n(例：ri-oubutsu)"
	collegeName = gets.chomp.downcase
end

#問題設定
print "大問数を入力"
numbersOfTaimon = gets.chomp.to_i
numbersOfShomon = Array.new(numbersOfTaimon + 1)
for i in 1..numbersOfTaimon do
	print "小問数を入力(ない場合は0を入力)"
	numbersOfShomon[i] = gets.chomp.to_i
end

#フォルダ名セット
univFolderPath = File.expand_path("../TEX-Genkou/14-Nyushi/14-" + ritsu + "/14-" + univName, __FILE__)
collegeFolderPath = univFolderPath + "/14-" + univShortName + "-" + collegeName
print univFolderPath


FileUtils::mkdir_p(collegeFolderPath)
for i in 1..numbersOfTaimon do
	if numbersOfShomon[i] == 0
		taimonFolderPath = collegeFolderPath + "/14-" + univShortName + "-" + collegeName + "-" + i.to_s
		FileUtils::mkdir_p(taimonFolderPath)
	else
		for j in 1..numbersOfShomon[i] do
			shomonFolderPath = collegeFolderPath + "/14-" + univShortName + "-" + collegeName + "-" + i.to_s + "-" + j.to_s
			FileUtils::mkdir_p(shomonFolderPath)
		end
	end
end
FileUtils::mkdir_p(collegeFolderPath + "/14-" + univShortName + "-" + collegeName + "-end")
FileUtils::mkdir_p(collegeFolderPath + "/14-" + univShortName + "-" + collegeName + "-matome")
