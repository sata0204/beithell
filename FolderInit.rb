# coding: sjis
################
#place the file on the directory includes TEX-Genkou
################

require 'fileutils'

#��w��{�ݒ�
print "������Ȃ�1���A������Ȃ�2�����"
is_kokuritsu = gets.chomp.to_i
case is_kokuritsu
when 1
	ritsu = "kokuritsu"
when 2
	ritsu = "shiritsu"
end

print "��w�������[�}��12���ȓ��œ���"
univ_name = gets.chomp.capitalize!
print "��w���̂����[�}���œ���"
univ_short_name = gets.chomp.upcase!

#�w���ݒ�
print "�P�w���Ȃ�1���A�����łȂ��Ȃ�2�����"
has_only_college = gets.chomp.to_i
if has_only_college == 1
	print "�O���Ȃ�1�A�����Ȃ�2�A����Ȃ�3�A��w���݂̂Ȃ�4�����"
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
	print "�w������10���ȓ��̃��[�}���œ���\n\
	�w�Ȗ���-�Ōq������\n(��Fri-oubutsu)"
	college_name = gets.chomp.downcase
end

#���ݒ�
#parts = ��� question = ����
print "��␔�����"
numbers_of_parts = gets.chomp.to_i
numbers_of_questions = Array.new(numbers_of_parts + 1)
for i in 1..numbers_of_parts do
	print "���␔�����(�Ȃ��ꍇ��0�����)"
	numbers_of_questions[i] = gets.chomp.to_i
end

#�t�H���_���Z�b�g
univ_folder_path = File.expand_path("../TEX-Genkou/14-Nyushi/14-" + ritsu + "/14-" + univ_name, __FILE__)
college_folder_path = univ_folder_path + "/14-" + univ_short_name + "-" + college_name
print univ_folder_path


FileUtils::mkdir_p(college_folder_path)
for i in 1..numbers_of_parts do
	if numbers_of_questions[i] == 0
		parts_folder_path = college_folder_path + "/14-" + univ_short_name + "-" + college_name + "-" + i.to_s
		FileUtils::mkdir_p(parts_folder_path)
	else
		for j in 1..numbers_of_questions[i] do
			questions_folder_path = college_folder_path + "/14-" + univ_short_name + "-" + college_name + "-" + i.to_s + "-" + j.to_s
			FileUtils::mkdir_p(questions_folder_path)
		end
	end
end
FileUtils::mkdir_p(college_folder_path + "/14-" + univ_short_name + "-" + college_name + "-end")
FileUtils::mkdir_p(college_folder_path + "/14-" + univ_short_name + "-" + college_name + "-matome")
