FasdUAS 1.101.10   ��   ��    k             l     �� ��    G A#### This handler is called when the prefs window is opend ####--       	  i      
  
 I     �� ��
�� .appSwilOnull���    obj   o      ���� 0 	theobject 	theObject��    k     F       I    	�� ��
�� .panSdlognull���    obj   l     ��  c         n         1    ��
�� 
pnam  o     ���� 0 	theobject 	theObject  m    ��
�� 
TEXT��  ��        l  
 
�� ��    ' !> Set the state of the prefrences         r   
     n   
     1    ��
�� 
pcnt  n   
      4    �� !
�� 
defE ! m     " "  prefLeadingZero      1   
 ��
�� 
useD  n       # $ # 1    ��
�� 
pcnt $ n     % & % 4    �� '
�� 
butT ' m     ( (  cb_LeadingZero    & 4    �� )
�� 
cwin ) m     * *  preferences      + , + r    / - . - n    % / 0 / 1   # %��
�� 
pcnt 0 n    # 1 2 1 4     #�� 3
�� 
defE 3 m   ! " 4 4  prefReplaceFiles    2 1     ��
�� 
useD . n       5 6 5 1   , .��
�� 
pcnt 6 n   % , 7 8 7 4   ) ,�� 9
�� 
butT 9 m   * + : :  cb_ReplaceFiles    8 4   % )�� ;
�� 
cwin ; m   ' ( < <  preferences    ,  =�� = r   0 F > ? > n   0 8 @ A @ 1   6 8��
�� 
pcnt A n   0 6 B C B 4   3 6�� D
�� 
defE D m   4 5 E E  prefScriptTimeout    C 1   0 3��
�� 
useD ? n       F G F 1   C E��
�� 
pcnt G n   8 C H I H 4   < C�� J
�� 
texF J m   ? B K K  tf_scriptTimeout    I 4   8 <�� L
�� 
cwin L m   : ; M M  preferences   ��   	  N O N l     ������  ��   O  P Q P l     �� R��   R H B#### This handler is called when the prefs window is closed ####--    Q  S T S i     U V U I     �� W��
�� .appSwilCnull���    obj  W o      ���� 0 	theobject 	theObject��   V k     v X X  Y Z Y l     �� [��   [ a [> Update the values in the plistfile based on the current stat of the UI in the pref window    Z  \ ] \ r      ^ _ ^ c      ` a ` n     	 b c b 1    	��
�� 
pcnt c n      d e d 4    �� f
�� 
butT f m     g g  cb_LeadingZero    e 4     �� h
�� 
cwin h m     i i  preferences    a m   	 
��
�� 
bool _ n       j k j 1    ��
�� 
pcnt k n     l m l 4    �� n
�� 
defE n m     o o  prefLeadingZero    m 1    ��
�� 
useD ]  p q p r    ) r s r c      t u t n     v w v 1    ��
�� 
pcnt w n     x y x 4    �� z
�� 
butT z m     { {  cb_ReplaceFiles    y 4    �� |
�� 
cwin | m     } }  preferences    u m    ��
�� 
bool s n       ~  ~ 1   & (��
�� 
pcnt  n     & � � � 4   # &�� �
�� 
defE � m   $ % � �  prefReplaceFiles    � 1     #��
�� 
useD q  � � � r   * @ � � � c   * 5 � � � n   * 3 � � � 1   1 3��
�� 
pcnt � n   * 1 � � � 4   . 1�� �
�� 
texF � m   / 0 � �  tf_scriptTimeout    � 4   * .�� �
�� 
cwin � m   , - � �  preferences    � m   3 4��
�� 
nmbr � n       � � � 1   = ?��
�� 
pcnt � n   5 = � � � 4   8 =�� �
�� 
defE � m   9 < � �  prefScriptTimeout    � 1   5 8��
�� 
useD �  � � � l  A A������  ��   �  � � � l  A A�� ���   � T N>If the prefs are changed during a session we need to update out global values    �  � � � r   A R � � � c   A P � � � n   A N � � � 1   L N��
�� 
pcnt � n   A L � � � 4   G L�� �
�� 
butT � m   H K � �  cb_LeadingZero    � 4   A G�� �
�� 
cwin � m   C F � �  preferences    � m   N O��
�� 
bool � o      ���� "0 prefleadingzero prefLeadingZero �  � � � r   S d � � � c   S b � � � n   S ` � � � 1   ^ `��
�� 
pcnt � n   S ^ � � � 4   Y ^�� �
�� 
butT � m   Z ] � �  cb_ReplaceFiles    � 4   S Y�� �
�� 
cwin � m   U X � �  preferences    � m   ` a��
�� 
bool � o      ���� $0 prefreplacefiles prefReplaceFiles �  ��� � r   e v � � � c   e t � � � n   e r � � � 1   p r��
�� 
pcnt � n   e p � � � 4   k p�� �
�� 
texF � m   l o � �  tf_scriptTimeout    � 4   e k�� �
�� 
cwin � m   g j � �  preferences    � m   r s��
�� 
nmbr � o      ���� &0 prefscripttimeout prefScriptTimeout��   T  � � � l     ������  ��   �  � � � i     � � � I     �� ���
�� .coVScliInull���    obj  � o      ���� 0 	theobject 	theObject��   � l      �� ���   �  Add your script here.    �  � � � l     ������  ��   �  � � � i     � � � I     �� � �
�� .panSpanEnull���    obj  � o      ���� 0 	theobject 	theObject � �� ���
�� 
witS � o      ���� 0 
withresult 
withResult��   � l      �� ���   �  Add your script here.    �  � � � l     ������  ��   �  � � � l      �� ���   �$
--#### This is called when the user whants to check for updates ####--
on clicked theObject
	--> Set a number for the current version
	set currentVersion to "22" as number
	
	--> Set the URL for the xml datafile
	set the_URL to "http://www.creatordesign.no/xpdf/data/update.xml"
	--> Open the xmldoc
	set the_doc to XMLOpen the_URL
	--> Set the root of the doc
	set the_root to XMLRoot the_doc
	
	-->  Locate the version in the XML doc 
	set the_child to XMLChild the_root index 2
	set newestVersion to XMLGetText the_child
	set newestVersion to newestVersion as number
	
	--> Close the xmlconnection
	XMLClose the_doc
	
	if newestVersion > currentVersion then
		display dialog "You dont have the latest version"
	else
		display dialog "You allready have the latest version"
	end if
	
end clicked
    �  � � � l     ������  ��   �  ��� � j    �� ��� 60 asdscriptuniqueidentifier ASDScriptUniqueIdentifier � m     � �  xPrefs.applescript   ��       �� � � � � � ���   � ����������
�� .appSwilOnull���    obj 
�� .appSwilCnull���    obj 
�� .coVScliInull���    obj 
�� .panSpanEnull���    obj �� 60 asdscriptuniqueidentifier ASDScriptUniqueIdentifier � �� ���� � ���
�� .appSwilOnull���    obj �� 0 	theobject 	theObject��   � ���� 0 	theobject 	theObject � ���������� "���� *�� ( 4 < : E M�� K
�� 
pnam
�� 
TEXT
�� .panSdlognull���    obj 
�� 
useD
�� 
defE
�� 
pcnt
�� 
cwin
�� 
butT
�� 
texF�� G��,�&j O*�,��/�,*��/��/�,FO*�,��/�,*��/��/�,FO*�,��/�,*��/a a /�,F � �� V���� � ���
�� .appSwilCnull���    obj �� 0 	theobject 	theObject��   � ���������� 0 	theobject 	theObject�� "0 prefleadingzero prefLeadingZero�� $0 prefreplacefiles prefReplaceFiles�� &0 prefscripttimeout prefScriptTimeout � �� i� g�~�}�|�{ o } { � ��z ��y � � � � � � �
�� 
cwin
� 
butT
�~ 
pcnt
�} 
bool
�| 
useD
�{ 
defE
�z 
texF
�y 
nmbr�� w*��/��/�,�&*�,��/�,FO*��/��/�,�&*�,��/�,FO*��/��/�,�&*�,�a /�,FO*�a /�a /�,�&E�O*�a /�a /�,�&E�O*�a /�a /�,�&E� � �x ��w�v � ��u
�x .coVScliInull���    obj �w 0 	theobject 	theObject�v   � �t�t 0 	theobject 	theObject �  �u h � �s ��r�q � ��p
�s .panSpanEnull���    obj �r 0 	theobject 	theObject�q �o�n�m
�o 
witS�n 0 
withresult 
withResult�m   � �l�k�l 0 	theobject 	theObject�k 0 
withresult 
withResult �  �p hascr  ��ޭ