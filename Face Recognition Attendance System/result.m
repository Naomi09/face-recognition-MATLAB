function result(a)
Recognized_index=a;
        filename='C:\Users\naomi\Desktop\UPDATED\Face Recognition Attendance System\attendancesheet.xlsx';
        
        if(Recognized_index<=5)
            
                xlswrite(filename, {'PRESENT'},'Sheet1', 'C2');
            
        end   
            
        if(Recognized_index>=6)&&(Recognized_index<=10)

           xlswrite(filename, {'PRESENT'},'Sheet1', 'C3');

           
        end  
        
        if(Recognized_index>10)&&(Recognized_index<=15)

           xlswrite(filename, {'PRESENT'},'Sheet1', 'C4');

           
        end
        
         if(Recognized_index>15)&&(Recognized_index<=25)

         
           xlswrite(filename, {'PRESENT'},'Sheet1', 'C5');

           
         end
        
         [num,txt,raw]=xlsread(filename);
raw(cellfun(@(x)all(x~=x), raw)) = {'ABSENT'} ;
xlswrite(filename,raw);
disp(raw);
