#coding=UTF-8
import random
import codecs

def dup(li):
	for index, item in enumerate(li):
		if index == 0:
			continue
		if li[index] == li[index-1]:
			return True
	return False

dataset = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789'
lines = open("username.txt").readlines()
length = len(lines)
li = []
for i in xrange(length):
	temp = random.sample(dataset, 6)
	stri = ''
	for ch in temp:
		stri += ch
	li.append(stri)
li = sorted(li)
if not dup(li):
	f = open('code.txt', 'w')
	for index in xrange(length):
		f.write(str(index)+' '+str(li[index])+' '+str(lines[index])+'\n')
	f.close()
	print 'done'