load('5by5.mat')

I=[];

for i1 =0:1
        for i2=0:1
            for i3=0:1
                for i4=0:1
                    for i5=0:1
                        for i6=0:1
                            for i7=0:1
                                for i8=0:1
                                    for i9=0:1
                                        for i10 =0:1
                                            for i11 =0:1
        for i12=0:1
            for i13=0:1
                for i14=0:1
                    for i15=0:1
                        for i16=0:1
                            for i17=0:1
                                for i18=0:1
                                    for i19=0:1
                                        for i20=0:1
                                            for i21=0:1
                                                for i22=0:1
                                                    for i23=0:1
                                                        for i24=0:1
                                                            for i25=0:1
                                                          

                                       
                I=[I; i25 i24 i23 i22 i21 i20 i19 i18 i17 i16 i15 i14 i13 i12 i11 i10 i9 i8 i7 i6 i5 i4 i3 i2 i1];
                        end
        end
                            end
                        end
    
                            end
                        end
                    end
                end
            end
        end
                                end
       end
                            end
                        end
        end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
end





   F=zeros(size(I,1),size(J,1));
    for i=1:size(I,1)
        for j=1:size(J,1)
            if ismember(find(J(j,:)~=0),find(I(i,:)~=0))
                F(i,j)=1;
            end
        end
    end
    
    save('IF.mat','I','F')


                