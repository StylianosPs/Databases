# ----- CONFIGURE YOUR EDITOR TO USE 4 SPACES PER TAB ----- #
import settings
import sys,os
sys.path.append(os.path.join(os.path.split(os.path.abspath(__file__))[0], 'lib'))
import pymysql as db

def connection():
    ''' User this function to create your connections '''
    con = db.connect(
        settings.mysql_host, 
        settings.mysql_user, 
        settings.mysql_passwd, 
        settings.mysql_schema)
    
    return con

def classify_review(reviewid):
    
    # Create a new connection
    # Create a new connection
    con=connection()
    # Create a cursor on the connection
    cur=con.cursor()

    cur.execute("SELECT text FROM reviews WHERE review_id = %s", reviewid)
    x = cur.fetchone()


    # Διαδικασία για την μέτρηση των posterms
    # 
    cur.execute("SELECT * FROM posterms")   
    tuples = cur.fetchall()


    # Εύρεση πλήθους λέξεων του text 
    x2 = x[0]
    z = x2.split(" ")
    size = len(z)

    # Διαδικάσια για n = 1
    # 
    i = 0
    count_p = 0     
    y = extract_ngrams(x[0], 1)     # Το y είναι μια λίστα όπου το πρώτο της μέρος θα είναι ο πρώτος όρος του text και το δεύτερο της 
                                    # μέρος θα αποτελεί το καινούριο αποκομένο text, όπου είναι το υπόλοιπο text χωρίς τον πρώτο όρο

    pos_list = [" "]                # Κρατά τα θετικά σχόλια που βρέθηκαν στο text και αποτελούνται από ένα όρο 

    # Διασχίζουμε το text και βρίσκουμε πόσους θετικούς όρους έχει το text για n = 1, όπου n->όροι
    for i in range(size-1):
        flag = 0
    
        for r in tuples:
            # Αν υπάρχει ο όρος στο text, τότε αύξησε το count κατά ένα
            if (y[0] == r[0]):
                count_p = count_p + 1
            
            # Αν ο όρος υπάρχει στην pos_list, τότε μείωσε το count κατά ένα
            # Ο λόγος είναι, για να βρεθεί στο pos_list σημαίνει πως ο  
            # όρος έχει βρεθεί προηγουμένος στο text
                for j in pos_list:
                    if (j == r[0]):
                        count_p = count_p - 1
                        flag = 1
                
                # Αν ο όρος δεν βρέθηκε στην pos_list, τότε πρόσθεσε τον όρο σ΄αυτή
                if(flag == 0): 
                    pos_list.append(y[0])

        # Καλούμε την extract_ngrams για να ξανά διασπάσει το text
        y = extract_ngrams(y[1], 1)

    
    # Διαδικάσια για n = 2
    # 
    i = 0
    y = extract_ngrams(x[0], 2)     # Το y είναι μια λίστα όπου το πρώτο της μέρος θα είναι ο πρώτος όρος του text, το δεύτερο της 
                                    # μέρος ο δεύτερος όρος και το τρίτο μέρος θα αποτελεί το καινούριο αποκομένο text, όπου είναι το 
                                    # υπόλοιπο text χωρίς τον πρώτο όρο
    
    # Διασχίζουμε το text και βρίσκουμε πόσους θετικούς όρους έχει το text για n = 2, όπου n->όροι
    for i in range(size - 2):
        for r in tuples:
            # Δημιουργούμε ένα string z με τον πρώτο και δεύτερο όρο του text
            z=y[0]+" "+y[1]

            # Ελέγχουμε αν το string υπάρχει στο text
            # Αν υπάρχει, τότε αύξησε το count κατά 2
            if (z == r[0]):
                count_p = count_p + 2
                
            # Ελέγχουμε αν υπάρχει ο πρώτος ή δεύτερος όρος του string στο pos_list
            # Αν υπάρχει, τότε μειώνουμε το count κατά ένα
                for j in pos_list:
                    if (j == y[0]):
                        count_p = count_p - 1
                    if (j == y[1]):
                        count_p = count_p - 1

        y = extract_ngrams(y[1]+" "+y[2], 2)
        

    # Διαδικάσια για n = 3
    # 
    i = 0
    y = extract_ngrams(x[0], 3)
    
    # Διασχίζουμε το text και βρίσκουμε πόσους θετικούς όρους έχει το text για n = 3, όπου n->όροι
    for i in range(size - 3):
        for r in tuples:
            # Δημιουργούμε ένα string z με τον πρώτο, δεύτερο και τρίτο όρο του text
            z=y[0]+" "+y[1]+" "+y[2]
            
            # Ελέγχουμε αν το string υπάρχει στο text
            # Αν υπάρχει, τότε αύξησε το count κατά 3
            if (z == r[0]):
                count_p = count_p + 3

            # Ελέγχουμε αν υπάρχει ο πρώτος ή δεύτερος ή τρίτος όρος του string στο pos_list
            # Αν υπάρχει, τότε μειώνουμε το count κατά ένα
                for j in pos_list:
                    if (j == y[0]):
                        count_p = count_p - 1
                    if (j == y[1]):
                        count_p = count_p - 1
                    if (j == y[2]):
                        count_p = count_p - 1

        y = extract_ngrams(y[1]+" "+y[2]+" "+y[3], 3)
        

    # Η διαδικασία για την μέτρηση των negterms είναι  
    # η ίδια με την μέτρηση των posterms
    # 
    cur.execute("SELECT * FROM negterms")      
    tuples = cur.fetchall()

    count_n = 0
    i = 0

    # Διαδικάσια για n = 1
    # 
    y = extract_ngrams(x[0], 1)
    neg_list = [" "]
    
    for i in range(size-1):
        flag = 0

        for r in tuples:
            if (y[0] == r[0]):
                count_n = count_n + 1
                
                for j in neg_list:
                    if (j == r[0]):
                        count_n = count_n - 1
                        flag = 1
                
                if(flag == 0): 
                    neg_list.append(y[0])
        
        y = extract_ngrams(y[1], 1)

    # Διαδικάσια για n = 2
    # 
    i = 0
    y = extract_ngrams(x[0], 2)
        
    for i in range(size - 2):
        for r in tuples:
            z=y[0]+" "+y[1]
           
            if (z == r[0]):
                count_n = count_n + 2
                
                for j in neg_list:
                    if (j == y[0]):
                        count_n = count_n - 1
                    if (j == y[1]):
                        count_n = count_n - 1
       
        y = extract_ngrams(y[1]+" "+y[2], 2)

    # Διαδικάσια για n = 3
    # 
    i = 0
    y = extract_ngrams(x[0], 3)
    
    for i in range(size - 3):
        for r in tuples:
            z=y[0]+" "+y[1]+" "+y[2]
            
            if (z == r[0]):
                count_n = count_n + 3
                
                for j in neg_list:
                    if (j == y[0]):
                        count_n = count_n - 1
                    if (j == y[1]):
                        count_n = count_n - 1
                    if (j == y[2]):
                        count_n = count_n - 1
        
        y = extract_ngrams(y[1]+" "+y[2]+" "+y[3], 3)
        
    cur.execute("SELECT b.name FROM reviews r, business b WHERE b.business_id=r.business_id and review_id = %s", reviewid)
    name=cur.fetchone()

    # Αν ο count_n > count_p, τότε το εστιατόριο έχει αρνητικά σχόλια, διαφορετικά έχει θετικά σχόλια
    if (count_n > count_p):
        return [("business_name","result"), (name[0],"negative"),]
    else:
        return [("business_name","result"), (name[0],"positive"),]
    
    

def extract_ngrams(text, num):
    # Create a new connection
    # Create a new connection
    con=connection()
    # Create a cursor on the connection
    cur=con.cursor()

    # Αν το num = 1, τότε θα μας δώσει μια λίστα με τον πρώτο όρο του text, καθώς και το υπόλοιπο text
    if (num == 1):
        x = text.split(" ", 1)

    # Αν το num = 2, τότε θα μας δώσει μια λίστα με τον πρώτο και δεύτερο όρο του text, καθώς και το υπόλοιπο text
    if (num == 2):
        x = text.split(" ", 2)

    # Αν το num = 3, τότε θα μας δώσει μια λίστα με τον πρώτο, δεύτερο και τρίτο όρο του text, καθώς και το υπόλοιπο text
    if (num == 3):
        x = text.split(" ", 3)

    return x



def updatezipcode(business_id,zipcode):
    
   # Create a new connection
    con=connection()
    
    # Create a cursor on the connection
    cur=con.cursor()
    cur.execute("SELECT zip_code FROM business WHERE business_id=%s",(business_id))

    rc=cur.rowcount
    if rc>0 : 
        cur.execute("UPDATE business SET zip_code=%s WHERE business_id=%s",(zipcode,business_id))
        return [("result","OK")]
    else:
        return [("result","ERROR")]



def selectTopNbusinesses(category_id,n):

    # Create a new connection
    
    con=connection()
    
    # Create a cursor on the connection
    cur=con.cursor()
    cur.execute("select r.business_id, count(*) from reviews r, reviews_pos_neg rpn, business_category bc where  bc.category_id = %s and r.business_id=bc.business_id and r.review_id=rpn.review_id and rpn.positive=1 group by r.business_id order by count(*) desc",(category_id))

    rows = cur.fetchmany(int(n))
    rows1=[("business_id","numberOfreviews",)]

    for r in rows:
        rows1.append(r)

    return rows1



def traceUserInfuence(userId,depth):
    # Create a new connection
    con=connection()

    # Create a cursor on the connection
    cur=con.cursor()

    return [("user_id",),]

        
