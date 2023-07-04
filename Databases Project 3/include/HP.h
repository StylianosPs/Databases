#include <stdlib.h>
#pragma once

#include "common_types.h"

typedef struct {
    int fileDesc; /* αναγνωριστικός αριθμός ανοίγματος αρχείου από το επίπεδο block */ 
    char attrType; /* ο τύπος του πεδίου που είναι κλειδί για το συγκεκριμένο αρχείο, 'c' ή'i' */ 
    char* attrName; /* το όνομα του πεδίου που είναι κλειδί για το συγκεκριμένο αρχείο */ 
    int attrLength; /* το μέγεθος του πεδίου που είναι κλειδί για το συγκεκριμένο αρχείο */
    int counter;    /* κρατά το πλήθος εγγραφών που υπάρχουν στο τελευταίο block*/
} HP_info;


//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// ΣΥΝΑΡΤΗΣΕΙΣ ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

int HP_CreateFile (char *fileName, char attrType, char* attrName, int attrLength);
HP_info* HP_OpenFile (char *fileName);
int HP_CloseFile (HP_info* header_info);
int HP_InsertEntry( HP_info header_info, Record record);
int HP_DeleteEntry( HP_info header_info, void *value);
int HP_GetAllEntries( HP_info header_info, void *value);