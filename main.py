key = [
    087h,0f2h,04dh,097h,
    06eh,04ch,090h,0ech,
    046h,0e7h,04ah,0c3h,
    0a6h,08ch,0d8h,095h]


MDS =[
     2, 3, 1, 1,
     1, 2, 3, 1,
     1, 1, 2, 3,
     3, 1, 1, 2 ]

for i in range(4):
    for j in range(4):
        print(i,j)
        #print(key[i+(j*4)])


print(key)

for i in range(4):
    ans2 =""
    for j in range(4):
        ans=""
        for x in range(4):
            AT = str(key[ (i) + (x*4) ])
            an =""
            if MDS[x+(j*4)]==1:

                an = an + "(" + "1" +"*"+AT+") "
            elif MDS[x+(j*4)] ==2:
                an = an + "(" + "2" +"*"+AT+") "
            elif MDS[x+(j*4)] ==3:
                an = an + "(" + "3" +"*"+AT+") "
            ans +=an
            #ans = ans+"("+ str(MDS[x+(j*4)])+ " * "+str(key[ (i) + (x*4) ]) +")"+" ¤ "
        print(ans)
        #print(ans)
        #print(key[(i*4)+(j)])

print(key)