# convert text file to excel sheet
#  useful when produce multiple sheets
#install.packages("rJava")
#install.packages("xlsx")
library(rJava)
library(xlsx)

textresult2excel_IPA = function(txtfile_dir){
  path_to_file = dirname(txtfile_dir)
  #dir(path_to_file)
  text.file = readLines(txtfile_dir)
  excel.filename = file.path(path_to_file, gsub(".txt", ".xlsx", basename(txtfile_dir)))

  CP.first=""
  UR.first=""
  CN.first=""
  DBF.first=""
  Mylist.first=""
  Mypathway.first=""
  NW.first=""
  RE.first=""
  Toxlist.first=""
  Analysisready.first=""
  for(i in 1:length(text.file)){
    tmp.line = text.file[i]
    if((CP.first=="")&grepl("^Canonical Pathways", tmp.line)){
      CP.first = i
    }
    if((UR.first=="")&grepl("^Upstream Regulators", tmp.line)){
      UR.first = i
    }
    if((CN.first=="")&grepl("^Causal Networks", tmp.line)){
      CN.first = i
    }
    if((DBF.first=="")&grepl("^Diseases and Bio Functions", tmp.line)){
        DBF.first = i
    }
    if((RE.first=="")&grepl("^Regulator Effects", tmp.line)){
      RE.first = i
    }
    if((NW.first=="")&grepl("^Networks", tmp.line)){
      NW.first = i
    }
    if((Mylist.first=="")&grepl("^My Lists", tmp.line)){
      Mylist.first = i
    }
    if((Toxlist.first=="")&grepl("^Tox Lists", tmp.line)){
      Toxlist.first = i
    }
    if((Mypathway.first=="")&grepl("^My Pathways", tmp.line)){
      Mypathway.first = i
    }
    if((Analysisready.first=="")&grepl("^Analysis Ready Molecules", tmp.line)){
      Analysisready.first = i
    }
  }

  write.xlsx(text.file[1:(CP.first-1)],  excel.filename, sheetName = "Setting", append = F, col.names = F, row.names = F)
  tmp = strsplit(text.file[(CP.first+1):(UR.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  write.xlsx(tmp.df, excel.filename, sheetName = "Canonical Pathways", append = T, col.names = F, row.names = F)
  
  tmp = strsplit(text.file[(UR.first+1):(CN.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  write.xlsx(tmp.df, excel.filename, sheetName = "Upstream Regulators", append = T, col.names = F, row.names = F)
  
  tmp = strsplit(text.file[(CN.first+1):(DBF.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  if(ncol(tmp.df)==0){
  }else{
    write.xlsx(tmp.df, excel.filename, sheetName = "Causal Networks", append = T, col.names = F, row.names = F)
  }
  
  tmp = strsplit(text.file[(DBF.first+1):(RE.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  if(ncol(tmp.df)==0){
  }else{
    write.xlsx(tmp.df, excel.filename, sheetName = "Diseases and Bio Functions", append = T, col.names = F, row.names = F)
  }
  
  tmp = strsplit(text.file[(RE.first+1):(NW.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  if(ncol(tmp.df)==0){
  }else{
    write.xlsx(tmp.df, excel.filename, sheetName = "Regulator Effects", append = T, col.names = F, row.names = F)
  }
  
  tmp = strsplit(text.file[(NW.first+1):(Mylist.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  if(ncol(tmp.df)==0){
  }else{
    write.xlsx(tmp.df, excel.filename, sheetName = "Networks", append = T, col.names = F, row.names = F)
  }
  
  tmp = strsplit(text.file[(Mylist.first+1):(Toxlist.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  if(ncol(tmp.df)==0){
  }else{
    write.xlsx(tmp.df, excel.filename, sheetName = "My list", append = T, col.names = F, row.names = F)
  }
  
  tmp = strsplit(text.file[(Toxlist.first+1):(Mypathway.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  if(ncol(tmp.df)==0){
  }else{
    write.xlsx(tmp.df, excel.filename, sheetName = "Tox list", append = T, col.names = F, row.names = F)
  }
  
  tmp = strsplit(text.file[(Mypathway.first+1):(Analysisready.first-1)], '\t') 
  tmp.df = do.call(rbind, tmp)
  if(ncol(tmp.df)==0){
  }else{
    write.xlsx(tmp.df, excel.filename, sheetName = "My pathways", append = T, col.names = F, row.names = F)
  }
  
  tmp = strsplit(text.file[(Analysisready.first+1):length(text.file)], '\t') 
  tmp.df = do.call(rbind, tmp)
  if(ncol(tmp.df)==0){
  }else{
    write.xlsx(tmp.df, excel.filename, sheetName = "Analysis Ready Molecules", append = T, col.names = F, row.names = F)
  }
}

path_to_file = "/media/2T_Disk/Dropbox/BBSR_P/Miyoung_Shin/IPA"
dir_file = grep(".txt", dir(path_to_file), value=T)
for(i in 1:length(dir_file)){
  textresult2excel_IPA(file.path(path_to_file, dir_file[i]))
}
