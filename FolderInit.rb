# coding: sjis
################
#place the file on the directory includes TEX-Genkou
################

require 'fileutils'

#��w��{�ݒ�
print "������Ȃ�1���A������Ȃ�2�����"
isKokuritsu = gets.chomp.to_i
case isKokuritsu
when 1
	ritsu = "kokuritsu"
when 2
	ritsu = "shiritsu"
end

print "��w�������[�}��12���ȓ��œ���"
univName = gets.chomp.capitalize!
print "��w���̂����[�}���œ���"
univShortName = gets.chomp.upcase!

#�w���ݒ�
print "�P�w���Ȃ�1���A�����łȂ��Ȃ�2�����"
hasOnlyCollege = gets.chomp.to_i
if hasOnlyCollege == 1
	print "�O���Ȃ�1�A�����Ȃ�2�A����Ȃ�3�A��w���݂̂Ȃ�4�����"
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
	print "�w������10���ȓ��̃��[�}���œ���\n\
	�w�Ȗ���-�Ōq������\n(��Fri-oubutsu)"
	collegeName = gets.chomp.downcase
end

#���ݒ�
print "��␔�����"
numbersOfTaimon = gets.chomp.to_i
numbersOfShomon = Array.new(numbersOfTaimon + 1)
for i in 1..numbersOfTaimon do
	print "���␔�����(�Ȃ��ꍇ��0�����)"
	numbersOfShomon[i] = gets.chomp.to_i
end

#�t�H���_���Z�b�g
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
