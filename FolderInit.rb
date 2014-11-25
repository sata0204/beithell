# coding: sjis
#########################################################
###place the file on the directory includes TEX-Genkou###
#########################################################

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
##parts = ��� question = ����
print "��␔�����"
numbers_of_parts = gets.chomp.to_i
numbers_of_questions = Array.new(numbers_of_parts + 1)
for i in 1..numbers_of_parts do
	print "���␔�����(�Ȃ��ꍇ��0�����)"
	numbers_of_questions[i] = gets.chomp.to_i
end

#�t�H���_���Z�b�g
univ_folder_path = File.expand_path("../TEX-Genkou/14-Nyushi/14-#{ritsu}/14-#{univ_name}", __FILE__)
univ_college_folder_name = "14-#{univ_short_name}-#{college_name}"
college_folder_path = "#{univ_folder_path}/#{univ_college_folder_name}"
##�t�H���_���̌ꊲ���Ɗ��p�������ʂɃZ�b�e�B���O
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

#�t�H���_���쐬
FileUtils::mkdir_p(college_folder_path)
suffixes_of_folders.each{|suffix|
    FileUtils::mkdir_p("#{college_folder_path}/#{univ_college_folder_name}-#{suffix}")
}
