FasdUAS 1.101.10   ��   ��    k             l     �� ��      xPDF.applescript       	  l     �� 
��   
  	 xPDF 2.0    	     l     ������  ��        l     �� ��    A ;  Created by Tom-Marius Olsen on 29.04.05, updated 06.11.06         l     �� ��    ; 5  Copyright 2006 Creator Design. All rights reserved.         l     ������  ��        l     ������  ��        l     �� ��     #### NOTES ####--         l      �� ��   ��
	#Table reordering
	The allow reordering feature of the NSTable dose'nt work. This might is beacause the drag `n dop is enabled, i haven�t found a workaround for this yet. 
	It's possible that it will work if I use a OutlineView insted of a TableView, but I havent tryed that yet
	CODE: set allows reordering of table view "fileList" of scroll view "files" of window "main" to true	
	
	#Lauch panel 
	When the application launches the awake from nib will not complete until the launching of InDesign is complete
	I have made a progressbar to display while ID cs2 launches, but for some reason the progressbar will not initiate either...
	Update. I have now messed about with different application handlers as "on launch" and "on will launch" and tried placing the 
	startingcode for the progress indicator in a handler called before any request to ID cs2 is made. But this dose'nt seem to work either
         l     ������  ��         l     �� !��   ! % #### Global vars go here ####--       " # " l     �� $��   $ j d> This is the name of the users startdisk, the var is assigned to it on the "awake from nib" handler    #  % & % p       ' ' ������ 0 	startdisk 	startDisk��   &  ( ) ( l     ������  ��   )  * + * l     �� ,��   , ~ x> This is an incremental used only when having multiple documents with multiple pages doing an incremental page extract.    +  - . - l     �� /��   / d ^> We need this to stick through several functions, so this seems like a god place to store it.    .  0 1 0 p       2 2 ������  0 runincremental runIncremental��   1  3 4 3 l     ������  ��   4  5 6 5 l     �� 7��   7 D >> Create the globals that will contain the data from the plist    6  8 9 8 l     �� :��   : � �> prefLeadingZero contains a boolean who dertermins wheter to use a leading zero in front of incrementals/pagenumbers less than 10    9  ; < ; p       = = ������ "0 prefleadingzero prefLeadingZero��   <  > ? > l     �� @��   @ c ]> prefReplaceFiles contains a boolean who determins wheter to replace allready existing files    ?  A B A p       C C ������ $0 prefreplacefiles prefReplaceFiles��   B  D E D l     �� F��   F h b>prefScriptTimeout is a number containing the number of minutes the applescript timeout is set to.    E  G H G p       I I ������ &0 prefscripttimeout prefScriptTimeout��   H  J K J l     ������  ��   K  L M L l     �� N��   N  ##################--    M  O P O l     �� Q��   Q  ##### ON LAUNCH #####--    P  R S R l     �� T��   T  ##################--    S  U V U l     ������  ��   V  W X W i      Y Z Y I     �� [��
�� .appSwiFLnull���    obj  [ o      ���� 0 	theobject 	theObject��   Z k     � \ \  ] ^ ] l     �� _��   _ , &> Display a progress bar while booting    ^  ` a ` I    �� b c
�� .panSdisQnull���    obj  b 4     �� d
�� 
cwin d m     e e  
lanchPanel    c �� f��
�� 
attT f 4    	�� g
�� 
cwin g m     h h 
 main   ��   a  i j i O    k l k I   ������
�� .coVSstaAnull���    obj ��  ��   l n     m n m 4    �� o
�� 
proI o m     p p  launcher    n 4    �� q
�� 
cwin q m     r r  
lanchPanel    j  s t s O   / u v u r   ) . w x w m   ) *��
�� boovtrue x 1   * -��
�� 
indR v n    & y z y 4   # &�� {
�� 
proI { m   $ % | |  launcher    z 4    #�� }
�� 
cwin } m   ! " ~ ~  
lanchPanel    t   �  l  0 0������  ��   �  � � � l  0 0�� ���   � d ^> Create the extra entrys in the plist file. ***If these are ignores if they allready are set.    �  � � � I  0 Q���� �
�� .corecrel****      � null��   � �� � �
�� 
kocl � m   2 3��
�� 
defE � �� � �
�� 
insh � n   4 : � � �  ;   9 : � n   4 9 � � � m   7 9��
�� 
defE � 1   4 7��
�� 
useD � �� ���
�� 
prdt � K   = K � � �� � �
�� 
pnam � m   @ C � �  prefLeadingZero    � �� ���
�� 
pcnt � m   F G��
�� boovtrue��  ��   �  � � � I  R s���� �
�� .corecrel****      � null��   � �� � �
�� 
kocl � m   T U��
�� 
defE � �� � �
�� 
insh � n   V \ � � �  ;   [ \ � n   V [ � � � m   Y [��
�� 
defE � 1   V Y��
�� 
useD � �� ���
�� 
prdt � K   _ m � � �� � �
�� 
pnam � m   b e � �  prefReplaceFiles    � �� ���
�� 
pcnt � m   h i��
�� boovtrue��  ��   �  � � � I  t ����� �
�� .corecrel****      � null��   � �� � �
�� 
kocl � m   v w��
�� 
defE � �� � �
�� 
insh � n   x ~ � � �  ;   } ~ � n   x } � � � m   { }��
�� 
defE � 1   x {��
�� 
useD � �� ���
�� 
prdt � K   � � � � �� � �
�� 
pnam � m   � � � �  prefScriptTimeout    � �� ���
�� 
pcnt � m   � � � �  30   ��  ��   �  � � � l  � �������  ��   �  � � � l  � ��� ���   � 4 .> Set the global variables from the plist file    �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
pcnt � n   � � � � � 4   � ��� �
�� 
defE � m   � � � �  prefLeadingZero    � 1   � ���
�� 
useD � o      ���� "0 prefleadingzero prefLeadingZero �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
pcnt � n   � � � � � 4   � ��� �
�� 
defE � m   � � � �  prefReplaceFiles    � 1   � ���
�� 
useD � o      ���� $0 prefreplacefiles prefReplaceFiles �  ��� � r   � � � � � n   � � � � � 1   � ���
�� 
pcnt � n   � � � � � 4   � ��� �
�� 
defE � m   � � � �  prefScriptTimeout    � 1   � ���
�� 
useD � o      ���� &0 prefscripttimeout prefScriptTimeout��   X  � � � l     ������  ��   �  � � � l     �� ���   � 0 *#### When the application launches  ####--    �  � � � i     � � � I     �� ���
�� .appSawFNnull���    obj  � o      ���� 0 	theobject 	theObject��   � k     � �  � � � l     �� ���   � " #### Make the toolbar ####--    �  � � � l     �� ���   � ; 5> Make the new toolbar, giving it a unique identifier    �  � � � r      � � � I    ��� �
�� .corecrel****      � null�   � �~ � �
�~ 
kocl � m    �}
�} 
tbar � �| � �
�| 
insh �  ;     � �{ ��z
�{ 
prdt � K     � � �y � �
�y 
pnam � m    	 � �  document toolbar    � �x � �
�x 
ideT � m   
  � � ! document toolbar identifier    � �w � �
�w 
allC � m    �v
�v boovtrue � �u � �
�u 
auSC � m    �t
�t boovfals � �s 
�s 
disM  m    �r
�r disMdeDM �q�p
�q 
sizM m    �o
�o sizMdeSM�p  �z   � o      �n�n "0 documenttoolbar documentToolbar �  l   �m�l�m  �l    l   �k�k   2 ,> Setup the allowed and default identifiers.    	 r    A

 J    ;  m      make item identifier     m    "  remove item identifier     m   " %  removeAll item identifier     m   % (  check errors identifier     m   ( +  options item identifier     m   + . &  customize toolbar item identifer      m   . 1!! # flexible space item identifer     "#" m   1 4$$  space item identifier   # %�j% m   4 7&&  separator item identifier   �j   n      '(' 1   < @�i
�i 
allI( o   ; <�h�h "0 documenttoolbar documentToolbar	 )*) r   B \+,+ J   B V-- ./. m   B E00  remove item identifier   / 121 m   E H33  removeAll item identifier   2 454 m   H K66  check errors identifier   5 787 m   K N99  options item identifier   8 :;: m   N Q<< # flexible space item identifer   ; =�g= m   Q T>>  make item identifier   �g  , n      ?@? 1   W [�f
�f 
defI@ o   V W�e�e "0 documenttoolbar documentToolbar* ABA l  ] ]�d�c�d  �c  B CDC l  ] ]�bE�b  E = 7> Create the toolbar items, adding them to the toolbar.   D FGF I  ] ��a�`H
�a .corecrel****      � null�`  H �_IJ
�_ 
koclI m   _ b�^
�^ 
tooIJ �]KL
�] 
inshK n   c iMNM  ;   h iN n   c hOPO 2  d h�\
�\ 
tooIP o   c d�[�[ "0 documenttoolbar documentToolbarL �ZQ�Y
�Z 
prdtQ K   j �RR �XST
�X 
ideTS m   k nUU  remove item identifier   T �WVW
�W 
pnamV m   o rXX  remove item   W �VYZ
�V 
labBY m   u x[[  Remove   Z �U\]
�U 
palL\ m   { ~^^  Remove   ] �T_`
�T 
tooT_ m   � �aa  Remove from list   ` �Sb�R
�S 
imaNb m   � �cc  
ico_remove   �R  �Y  G ded I  � ��Q�Pf
�Q .corecrel****      � null�P  f �Ogh
�O 
koclg m   � ��N
�N 
tooIh �Mij
�M 
inshi n   � �klk  ;   � �l n   � �mnm 2  � ��L
�L 
tooIn o   � ��K�K "0 documenttoolbar documentToolbarj �Jo�I
�J 
prdto K   � �pp �Hqr
�H 
ideTq m   � �ss  removeAll item identifier   r �Gtu
�G 
pnamt m   � �vv  removeAll item   u �Fwx
�F 
labBw m   � �yy  
Remove all   x �Ez{
�E 
palLz m   � �||  
Remove All   { �D}~
�D 
tooT} m   � �  Remove all from list   ~ �C��B
�C 
imaN� m   � ���  ico_removeall   �B  �I  e ��� I  � ��A�@�
�A .corecrel****      � null�@  � �?��
�? 
kocl� m   � ��>
�> 
tooI� �=��
�= 
insh� n   � ����  ;   � �� n   � ���� 2  � ��<
�< 
tooI� o   � ��;�; "0 documenttoolbar documentToolbar� �:��9
�: 
prdt� K   � ��� �8��
�8 
ideT� m   � ���  options item identifier   � �7��
�7 
pnam� m   � ���  options item   � �6��
�6 
labB� m   � ���  PDF Options   � �5��
�5 
palL� m   � ���  PDF Options   � �4��
�4 
tooT� m   � ���  Open PDF options   � �3��2
�3 
imaN� m   � ���  
ico_drawer   �2  �9  � ��� I  �,�1�0�
�1 .corecrel****      � null�0  � �/��
�/ 
kocl� m   � ��.
�. 
tooI� �-��
�- 
insh� n   ����  ;  � n   ���� 2  �,
�, 
tooI� o   � �+�+ "0 documenttoolbar documentToolbar� �*��)
�* 
prdt� K  (�� �(��
�( 
ideT� m  
��  make item identifier   � �'��
�' 
pnam� m  ��  	make item   � �&��
�& 
labB� m  ��  
Create PDF   � �%��
�% 
palL� m  ��  
Create PDF   � �$��
�$ 
tooT� m   ��  Create PDF files   � �#��"
�# 
imaN� m  #&��  ico_makepdf   �"  �)  � ��� I -`�!� �
�! .corecrel****      � null�   � ���
� 
kocl� m  /2�
� 
tooI� ���
� 
insh� n  39���  ;  89� n  38��� 2 48�
� 
tooI� o  34�� "0 documenttoolbar documentToolbar� ���
� 
prdt� K  :\�� ���
� 
ideT� m  ;>��  check errors identifier   � ���
� 
pnam� m  ?B��  check errors   � ���
� 
labB� m  EH��  Check errors   � ���
� 
palL� m  KN��  Check errors   � ���
� 
tooT� m  QT��  Check files for errors   � ���
� 
imaN� m  WZ��  ico_checkerror   �  �  � ��� l aa���  �  � ��� l aa���  � ( "> Assign our toolbar to the window   � ��� r  af��� o  ab�� "0 documenttoolbar documentToolbar� n      ��� m  ce�
� 
tbar� o  bc�� 0 	theobject 	theObject� ��� l gg��
�  �
  � ��� l gg�	��	  � 2 ,#### Open the drawer with the options ####--   � ��� O  g���� O r���� I }����
� .caVSopeDnull���    obj �  � ���
� 
on O� m  ���
� EReTrigE�  � 4  rz��
� 
draA� m  vy��  drawer   � 4  go��
� 
cwin� m  kn�� 
 main   � ��� l ���� �  �   � ��� l �������  �  #### Alter the UI ####--   � ��� l �������  � @ :> Dissallow the user to choose basename and page-extract.    �    r  �� m  ����
�� boovfals n       1  ����
�� 
ediT n  �� 4  ����
�� 
texF m  ��		  tf_baseName    n  ��

 4  ����
�� 
boxO m  ��  options    n  �� 4  ����
�� 
draA m  ��  drawer    4  ����
�� 
cwin m  �� 
 main     r  �� m  ����
�� boovfals n       1  ����
�� 
enaB n  �� 4  ����
�� 
matT m  ��  rg_extractPagesSuffix    n  �� 4  ���� 
�� 
boxO  m  ��!!  options    n  ��"#" 4  ����$
�� 
draA$ m  ��%%  drawer   # 4  ����&
�� 
cwin& m  ��'' 
 main    ()( l ��������  ��  ) *+* l ����,��  , . (#### Set the name of the basedisk ####--   + -��- O  �./. k  �
00 121 r  ��343 c  ��565 1  ����
�� 
sdsk6 m  ����
�� 
TEXT4 o      ���� 0 	startdisk 	startDisk2 7��7 r  �
898 c  �:;: l �<��< n  �=>= 7 ���?@
�� 
cha ? m  ������ @ l �A��A \  �BCB l ��D��D n  ��EFE m  ����
�� 
nmbrF n  ��GHG 2 ����
�� 
cha H o  ������ 0 	startdisk 	startDisk��  C m  � ���� ��  > o  ������ 0 	startdisk 	startDisk��  ; m  ��
�� 
TEXT9 l     I��I o      ���� 0 	startdisk 	startDisk��  ��  / m  ��JJ�null     ߀��  �
Finder.app\�     9W0�d[$��� D�B�O��dbȿ��   �]b��\[$     MACS   alis    r  Macintosh HD               �F�
H+    �
Finder.app                                                       2���M� � 0 � �����  	                CoreServices    �F��      ��1�      �  
�  
�  3Macintosh HD:System:Library:CoreServices:Finder.app    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��   � KLK l     ������  ��  L MNM i    OPO I     ��Q��
�� .appSlauNnull���    obj Q o      ���� 0 	theobject 	theObject��  P k     �RR STS l     ��U��  U + %#### Launch Adobe InDesign CS2 ####--   T VWV Q     OXYZX k    [[ \]\ l   ��^��  ^ O I#### Populate the drop-downmenu with the PDF presets from InDesign ####--   ] _`_ l   ��a��  a - '> Get the all the presets from InDesign   ` b��b O    cdc k    ee fgf l   ��h��  h # > Get the presets into a list   g iji r    klk c    mnm n    opo 1   
 ��
�� 
pnamp 2    
��
�� 
PFstn m    ��
�� 
listl o      ���� 0 pdfpresetlist PDFpresetListj qrq l   ��s��  s &  >Get number of items in the list   r t��t r    uvu l   w��w n    xyx m    ��
�� 
nmbry n    z{z 2   ��
�� 
cobj{ o    ���� 0 pdfpresetlist PDFpresetList��  v o      ���� 0 numofpreset numOfPreset��  d m    ||
null     ߀�� ݼAdobe InDesign CS2.appd[$��� D�B�$ �\��    ��T   �)����� 9InDn   alis    �  Macintosh HD               �F�
H+   ݼAdobe InDesign CS2.app                                          �ľt.�        ����  	                Adobe InDesign CS2    �F��      �t�     ݼ  �  CMacintosh HD:Applications:Adobe InDesign CS2:Adobe InDesign CS2.app   .  A d o b e   I n D e s i g n   C S 2 . a p p    M a c i n t o s h   H D  6Applications/Adobe InDesign CS2/Adobe InDesign CS2.app  / ��  ��  Y R      ������
�� .ascrerr ****      � ****��  ��  Z I  ! O��}~
�� .panSdisAnull���    obj } m   ! "  Sorry...   ~ ����
�� 
as A� m   # $��
�� EAlTwarN� ����
�� 
mesS� b   % 8��� b   % 4��� b   % .��� b   % ,��� m   % &�� + %xPDF can't locate Adobe InDesign CS2.   � l  & +���� I  & +�����
�� .sysontocTEXT       shor� m   & '���� 
��  ��  � m   , -�� ! Try visiting our webpage at   � l  . 3���� I  . 3�����
�� .sysontocTEXT       shor� m   . /���� 
��  ��  � m   4 7�� ' !http://www.creatordesign.no/xpdf/   � ����
�� 
defB� m   ; >��  Ok   � �����
�� 
attT� 4   A I���
�� 
cwin� m   E H�� 
 main   ��  W ��� l  P P������  ��  � ��� l  P P�����  � v p> First we need to make sure there the combobox is empty, to do this we need to delete all the menu items in it.   � ��� I  P k�����
�� .coredelonull���    obj � n   P g��� 2   c g��
�� 
menI� n   P c��� m   _ c��
�� 
menE� n   P _��� 4   X _���
�� 
popB� m   [ ^��  PDFPresetList   � 4   P X���
�� 
cwin� m   T W�� 
 main   ��  � ��� l  l l�����  � U O> then add all our new menu items to the combobox based on the list we retrived   � ��� Y   l ��������� I  v ������
�� .corecrel****      � null��  � ����
�� 
kocl� m   z }��
�� 
menI� ����
�� 
insh� l  � ����� n   � ����  ;   � �� n   � ���� 2  � ���
�� 
menI� n   � ���� m   � ���
�� 
menE� n   � ���� 4   � ����
�� 
popB� m   � ���  PDFPresetList   � 4   � ����
�� 
cwin� m   � ��� 
 main   ��  � �����
�� 
prdt� K   � ��� ����
�� 
titl� l  � ����� n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 i  � o   � ����� 0 pdfpresetlist PDFpresetList��  � �����
�� 
enaB� m   � ���
�� boovtrue��  ��  �� 0 i  � m   o p���� � o   p q���� 0 numofpreset numOfPreset��  � ��� l  � �������  ��  � ��� n  � ���� I   � ��������  0 updatedsummary updatedSummary� ���� n   � ���� 4   � ����
�� 
cobj� m   � ����� � o   � ����� 0 pdfpresetlist PDFpresetList��  ��  �  f   � �� ��� l  � �������  ��  � ��� l  � ������  � 1 +> Its is now safe to remove the launchpanel   � ��� I  � ������
�� .panScloPnull���    obj � 4   � ����
�� 
cwin� m   � ���  
lanchPanel   ��  � ���� l  � �������  ��  ��  N ��� l     ������  ��  � ��� l     ��~�  �~  � ��� l     �}��}  �  ################--   � ��� l     �|��|  �  ##### TOOLBAR #####--   � ��� l     �{��{  �  ################--   � ��� l     �z�y�z  �y  � ��� l     �x��x  � _ Y#### This event handler is called when the user clicks on one of the toolbar items ####--   � ��� l     �w��w  � > 8> theObject used is the identifier of the butten pressed   � ��� i    ��� I     �v��u
�v .appSclTInull���    obj � o      �t�t 0 	theobject 	theObject�u  � k    V�� � � l     �s�s   3 -#### If the make PDF button is pressed ####--     �r Z    V�q =     n     	 1    �p
�p 
ideT	 o     �o�o 0 	theobject 	theObject m    

  make item identifier    k   �  l   �n�n   Y S> The golbal runIncremental must be reset every time we try to run the batchprocess     r     m    	�m�m   o      �l�l  0 runincremental runIncremental  l   �k�j�k  �j    l   �i�i   a [> First check if there are any files in the list, if not we need to display a error message     r     n     m    �h
�h 
nmbr n     2   �g
�g 
datR n     !  m    �f
�f 
datS! n    "#" 4    �e$
�e 
tabW$ m    %%  fileList   # n    &'& 4    �d(
�d 
scrV( m    ))  files   ' 4    �c*
�c 
cwin* m    ++ 
 main    o      �b�b $0 filelistchecknum fileListChecknum ,-, Z    H./�a�`. =   "010 o     �_�_ $0 filelistchecknum fileListChecknum1 m     !�^�^  / k   % D22 343 I  % A�]56
�] .panSdisAnull���    obj 5 m   % &77  No files added!   6 �\89
�\ 
as A8 m   ' (�[
�[ EAlTwarN9 �Z:;
�Z 
mesS: m   ) ,<< 6 0Please add some InDesignfiles to the list first.   ; �Y=>
�Y 
defB= m   / 2??  Ok   > �X@�W
�X 
attT@ 4   5 ;�VA
�V 
cwinA m   7 :BB 
 main   �W  4 CDC l  B B�UE�U  E / )> Return false to exit rest of the script   D F�TF L   B DGG m   B C�S
�S boovfals�T  �a  �`  - HIH l  I I�R�Q�R  �Q  I JKJ l  I I�PL�P  L 5 /#### Set the values from the options box ####--   K MNM l  I I�OO�O  O ; 5> Set the value for savinglocation as a boolean value   N PQP r   I nRSR c   I lTUT n   I hVWV 1   d h�N
�N 
pcntW n   I dXYX 4   ] d�MZ
�M 
butTZ m   ` c[[  cb_chooseSave   Y n   I ]\]\ 4   V ]�L^
�L 
boxO^ m   Y \__  options   ] n   I V`a` 4   O V�Kb
�K 
draAb m   R Ucc  drawer   a 4   I O�Jd
�J 
cwind m   K Nee 
 main   U m   h k�I
�I 
boolS o      �H�H &0 savelocationcheck saveLocationCheckQ fgf l  o o�Gh�G  h 5 /> Set the value for basename as a boolean value   g iji r   o �klk c   o �mnm n   o �opo 1   � ��F
�F 
pcntp n   o �qrq 4   � ��Es
�E 
butTs m   � �tt  cb_baseName   r n   o �uvu 4   | ��Dw
�D 
boxOw m    �xx  options   v n   o |yzy 4   u |�C{
�C 
draA{ m   x {||  drawer   z 4   o u�B}
�B 
cwin} m   q t~~ 
 main   n m   � ��A
�A 
booll o      �@�@ 0 basenamecheck baseNameCheckj � l  � ��?��?  � 9 3> Set the value for basename text as a string value   � ��� r   � ���� c   � ���� n   � ���� 1   � ��>
�> 
pcnt� n   � ���� 4   � ��=�
�= 
texF� m   � ���  tf_baseName   � n   � ���� 4   � ��<�
�< 
boxO� m   � ���  options   � n   � ���� 4   � ��;�
�; 
draA� m   � ���  drawer   � 4   � ��:�
�: 
cwin� m   � ��� 
 main   � m   � ��9
�9 
TEXT� o      �8�8 0 basenametext baseNameText� ��� l  � ��7��7  � < 6> Set the value for page extraction as a boolean value   � ��� r   � ���� c   � ���� n   � ���� 1   � ��6
�6 
pcnt� n   � ���� 4   � ��5�
�5 
butT� m   � ���  cb_extractPages   � n   � ���� 4   � ��4�
�4 
boxO� m   � ���  options   � n   � ���� 4   � ��3�
�3 
draA� m   � ���  drawer   � 4   � ��2�
�2 
cwin� m   � ��� 
 main   � m   � ��1
�1 
bool� o      �0�0 &0 extractpagescheck extractPagesCheck� ��� l  � ��/��/  � 6 0> Set the type of suffix for the pagesextraction   � ��� r   ���� c   ���� n   � ��� 1   � �.
�. 
curR� n   � ���� 4   � ��-�
�- 
matT� m   � ���  rg_extractPagesSuffix   � n   � ���� 4   � ��,�
�, 
boxO� m   � ���  options   � n   � ���� 4   � ��+�
�+ 
draA� m   � ���  drawer   � 4   � ��*�
�* 
cwin� m   � ��� 
 main   � m   �)
�) 
nmbr� o      �(�( $0 extractpagestype extractPagesType� ��� l �'��'  � ; 5> Set the value for missing images as a boolean value   � ��� r  *��� c  (��� n  $��� 1   $�&
�& 
pcnt� n   ��� 4   �%�
�% 
butT� m  ��  cb_missingImages   � n  ��� 4  �$�
�$ 
boxO� m  ��  options   � n  ��� 4  �#�
�# 
draA� m  ��  drawer   � 4  �"�
�" 
cwin� m  
�� 
 main   � m  $'�!
�! 
bool� o      � �  (0 missingimagescheck missingImagesCheck� ��� l ++���  � : 4> Set the value for missing fonts as a boolean value   � ��� r  +P��� c  +N��� n  +J��� 1  FJ�
� 
pcnt� n  +F��� 4  ?F��
� 
butT� m  BE��  cb_missingFonts   � n  +?��� 4  8?��
� 
boxO� m  ;>��  options   � n  +8��� 4  18��
� 
draA� m  47��  drawer   � 4  +1��
� 
cwin� m  -0�� 
 main   � m  JM�
� 
bool� o      �� &0 missingfontscheck missingFontsCheck� ��� l QQ���  � $ > Set PDF-export preset to use   � � � r  Qh c  Qf n  Qb 1  ^b�
� 
titl n  Q^ 4  W^�	
� 
popB	 m  Z]

  PDFPresetList    4  QW�
� 
cwin m  SV 
 main    m  be�
� 
TEXT o      �� "0 pdfexportpreset PDFExportPreset   l ii���  �    l ii��   $ #### Open the savepanel ####--     l ii��   _ Y> If the value of the savingloaction is set to true we display the sanvinglocaition panel     Z  i�� o  ij�� &0 savelocationcheck saveLocationCheck k  m�  l mm��   , &> Set the attributes for the savepanel     O  m� !  k  u�"" #$# l uu�
%�
  % # > Set the title of the window   $ &'& r  u~()( m  ux**  Choose a folder   ) 1  x}�	
�	 
titl' +,+ l �-�  - " > Set the name of the button   , ./. r  �010 m  �22 
 Save   1 1  ���
� 
proO/ 343 l ���5�  5 ! > Dissallow packagebrowsing   4 676 r  ��898 m  ���
� boovfals9 1  ���
� 
tPAD7 :;: l ���<�  < ) #> Allow the user to choose a folder   ; =>= r  ��?@? m  ���
� boovtrue@ 1  ���
� 
caCD> ABA l ��� C�   C + %> Dissallow the user to choose a file   B DED r  ��FGF m  ����
�� boovfalsG 1  ����
�� 
caCFE HIH l ����J��  J 8 2> Dissallow the user to select multipel selections   I K��K r  ��LML m  ����
�� boovfalsM 1  ����
�� 
alMT��  ! 1  mr��
�� 
opeP NON l ����P��  P 8 2> Display the savepanel and set the var withResult   O Q��Q r  ��RSR I ����T��
�� .panSdisPnull���    obj T 1  ����
�� 
opeP��  S o      ���� 0 
saveresult 
saveResult��  �   k  ��UU VWV l ����X��  X � �> Even if the savepanel dosen't appear we still whant to contiue. Because this only means that the savelocation is not to be choosen   W Y��Y r  ��Z[Z m  ������ [ o      ���� 0 
saveresult 
saveResult��   \]\ l ��������  ��  ] ^_^ l ����`��  ` 6 0#### Set path returned from the savepanel ####--   _ aba Z  ��cd����c = ��efe o  ������ 0 
saveresult 
saveResultf m  ������ d k  ��gg hih Z  �jk��lj o  ������ &0 savelocationcheck saveLocationCheckk k  ��mm non l ����p��  p s m For some unknown (as of yet) you must coerce the 'path names' to a list (even though it is defined as list).   o qrq r  ��sts l ��u��u c  ��vwv n  ��xyx 1  ����
�� 
filOy 1  ����
�� 
opePw m  ����
�� 
list��  t l     z��z o      ���� 0 
savefolder 
saveFolder��  r {|{ r  ��}~} m  ��  /   ~ n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr| ��� r  ����� c  ����� b  ����� b  ����� o  ������ 0 	startdisk 	startDisk� o  ������ 0 
savefolder 
saveFolder� m  ����  :   � m  ����
�� 
TEXT� l     ���� o      ���� 0 
savefolder 
saveFolder��  � ���� r  ����� m  ����      � n     ��� 1  ����
�� 
txdl� 1  ����
�� 
ascr��  ��  l k   �� ��� l   �����  � � �> If saveLocationCheck is set to false we create a empty variable to store the saveFoler beacuse we still need to pass it into the createPDF function   � ���� r   ��� m   ��      � o      ���� 0 
savefolder 
saveFolder��  i ��� l ������  ��  � ��� l �����  � ( "#### Open the prgress panel ####--   � ��� l �����  � ? 9> Open the progressbar window attached to the main window   � ��� I ����
�� .panSdisQnull���    obj � 4  ���
�� 
cwin� m  ��  progressPanel   � �����
�� 
attT� 4  ���
�� 
cwin� m  �� 
 main   ��  � ��� O 2��� r  *1��� m  *+��
�� boovfals� 1  +0��
�� 
indR� n  '��� 4   '���
�� 
proI� m  #&��  progress   � 4   ���
�� 
cwin� m  ��  progressPanel   � ��� l 33������  ��  � ��� l 33�����  � C =#### Set the datasources for the values in the NSTable ####--   � ��� l 33�����  � G A>Create a new datasource containing all the files in the NSTable.   � ��� r  3G��� n  3E��� m  CE��
�� 
datS� n  3C��� 4  >C���
�� 
tabW� m  ?B��  fileList   � n  3>��� 4  9>���
�� 
scrV� m  :=��  files   � 4  39���
�� 
cwin� m  58�� 
 main   � o      ����  0 filelistsource fileListSource� ��� l HH�����  � ? 9> Retrive the complete paths & filenames from the NSTable   � ��� r  Hi��� n  Hg��� 1  cg��
�� 
pcnt� n  Hc��� 4  \c���
�� 
datC� m  _b�� 
 path   � n  H\��� 2 Z\��
�� 
datR� n  HZ��� m  XZ��
�� 
datS� n  HX��� 4  SX���
�� 
tabW� m  TW��  fileList   � n  HS��� 4  NS���
�� 
scrV� m  OR��  files   � 4  HN���
�� 
cwin� m  JM�� 
 main   � o      ���� 0 thepaths thePaths� ��� r  j���� n  j���� 1  ����
�� 
pcnt� n  j���� 4  ~����
�� 
datC� m  ����  files   � n  j~��� 2 |~��
�� 
datR� n  j|��� m  z|��
�� 
datS� n  jz��� 4  uz���
�� 
tabW� m  vy��  fileList   � n  ju��� 4  pu�� 
�� 
scrV  m  qt  files   � 4  jp��
�� 
cwin m  lo 
 main   � o      ���� 0 thefiles theFiles�  l ��������  ��    l ������   : 4#### Count the number of pages in the NSTabel ####--    	
	 l ������   . (> Set the number of files in the NSTable   
  r  �� n  �� m  ����
�� 
nmbr n  �� 2 ����
�� 
datR n  �� m  ����
�� 
datS n  �� 4  ����
�� 
tabW m  ��  fileList    n  �� 4  ����
�� 
scrV m  ��  files    4  ����
�� 
cwin m  �� 
 main    o      ���� 0 
numoffiles 
numOfFiles  !  l ��������  ��  ! "#" l ����$��  $ K E> Set the var for containing the total number of pages to be desilled   # %&% r  ��'(' m  ������  ( o      ���� 0 
totalpages 
totalPages& )*) l ��������  ��  * +,+ l ����-��  - Z T> Count up all the pages to be destilled, this will be used to make the progressbar    , ./. Y  ��0��12��0 k  ��33 454 l ����6��  6 Y S> For each loop the var totalPages equals the previous totalPages pluss the current   5 787 r  ��9:9 c  ��;<; b  ��=>= o  ������ 0 	startdisk 	startDisk> n  ��?@? 4  ����A
�� 
cobjA o  ������ 0 count_i  @ o  ������ 0 thepaths thePaths< m  ����
�� 
TEXT: o      ���� 0 open_document  8 BCB l ����D��  D \ V> Indesign does not understand the "/" delimiters, so we need to replace them with ":"   C EFE r  ��GHG c  ��IJI l ��K��K n ��LML I  ����N���� 0 makecolonpath makeColonpathN O��O o  ������ 0 open_document  ��  ��  M  f  ����  J m  ����
�� 
TEXTH o      ���� 0 open_document  F P��P r  ��QRQ [  ��STS o  ������ 0 
totalpages 
totalPagesT l ��U��U n ��VWV I  ����X���� 0 
countpages 
countPagesX Y��Y o  ������ 0 open_document  ��  ��  W  f  ����  R o      �� 0 
totalpages 
totalPages��  �� 0 count_i  1 m  ���~�~ 2 o  ���}�} 0 
numoffiles 
numOfFiles��  / Z[Z l ���|�{�|  �{  [ \]\ l ���z^�z  ^ * $#### Initiate the progressbar ####--   ] _`_ l ���ya�y  a e _> Now that we know the number of pages the need to be distilled we can initiate the progressbar   ` bcb n ��ded I  ���xf�w�x $0 initiateporgress initiatePorgressf g�vg o  ���u�u 0 
totalpages 
totalPages�v  �w  e  f  ��c hih l ���t�s�t  �s  i jkj l ���rl�r  l u o#### This is the main loop that loopes through all the files NSTable and executes the createPDF function ####--   k mnm l ���qo�q  o > 8>The loop is based on the number of files in out NSTable   n pqp Y  ��r�pst�or k  �uu vwv l �nx�n  x � �#### Set the path to the document to open. InDesign does not understand the "/" delimiters, so we need to replace them with ":" ####--   w yzy r  {|{ c  }~} b  � o  �m�m 0 	startdisk 	startDisk� n  ��� 4  �l�
�l 
cobj� o  �k�k 0 i  � o  �j�j 0 thepaths thePaths~ m  �i
�i 
TEXT| o      �h�h 0 opendocument openDocumentz ��� l �g��g  � N H>Debug display dialog (item i of thePaths as string) default button "ok"   � ��� r  )��� c  %��� l !��f� n !��� I  !�e��d�e 0 makecolonpath makeColonpath� ��c� o  �b�b 0 opendocument openDocument�c  �d  �  f  �f  � m  !$�a
�a 
TEXT� o      �`�` 0 opendocument openDocument� ��� l **�_�^�_  �^  � ��� l **�]��]  � > 8#### Set the path to the documents savinglocation ####--   � ��� l **�\��\  � k e> If the baseNameCheck is set to false we need to get the folder whitch contains the current document   � ��� Z  *����[�� H  *,�� o  *+�Z�Z &0 savelocationcheck saveLocationCheck� k  /��� ��� l //�Y��Y  � 4 .> Get the number of characters in the filename   � ��� r  /C��� c  /?��� n  /=��� m  ;=�X
�X 
nmbr� n  /;��� 2 7;�W
�W 
cha � n  /7��� 4  07�V�
�V 
cobj� o  36�U�U 0 i  � o  /0�T�T 0 thefiles theFiles� m  =>�S
�S 
nmbr� o      �R�R 0 length_filename  � ��� l DD�Q��Q  � N H> Remove the filename from the filepath to get path to the parent folder   � ��� r  Ds��� c  Dq��� b  Dm��� o  DG�P�P 0 	startdisk 	startDisk� l Gl��O� n  Gl��� 7 Ol�N��
�N 
cha � m  UW�M�M � l Xk��L� \  Xk��� l Yg��K� n  Yg��� m  eg�J
�J 
nmbr� n  Ye��� 2 ae�I
�I 
cha � n  Ya��� 4  Za�H�
�H 
cobj� o  ]`�G�G 0 i  � o  YZ�F�F 0 thepaths thePaths�K  � o  gj�E�E 0 length_filename  �L  � n  GO��� 4  HO�D�
�D 
cobj� o  KN�C�C 0 i  � o  GH�B�B 0 thepaths thePaths�O  � m  mp�A
�A 
TEXT� o      �@�@ 0 
savefolder 
saveFolder� ��� l tt�?��?  � * $> Create a colon separeted filepath    � ��>� r  t���� c  t~��� l tz��=� n tz��� I  uz�<��;�< 0 makecolonpath makeColonpath� ��:� o  uv�9�9 0 
savefolder 
saveFolder�:  �;  �  f  tu�=  � m  z}�8
�8 
TEXT� o      �7�7 0 
savefolder 
saveFolder�>  �[  � k  ���� ��� l ���6��6  � * $> Create a colon separeted filepath    � ��5� r  ����� c  ����� l ����4� n ����� I  ���3��2�3 0 makecolonpath makeColonpath� ��1� o  ���0�0 0 
savefolder 
saveFolder�1  �2  �  f  ���4  � m  ���/
�/ 
TEXT� o      �.�. 0 
savefolder 
saveFolder�5  � ��� l ���-�,�-  �,  � ��+� Z  �����*�� = ����� l ����)� n ����� I  ���(��'�( 0 	createpdf 	createPDF� ��� o  ���&�& 0 opendocument openDocument� ��� o  ���%�% 0 
savefolder 
saveFolder� ��� o  ���$�$ "0 pdfexportpreset PDFExportPreset� ��� o  ���#�# 0 basenamecheck baseNameCheck� ��� o  ���"�" 0 basenametext baseNameText�    o  ���!�! &0 extractpagescheck extractPagesCheck  o  ��� �  $0 extractpagestype extractPagesType  o  ���� (0 missingimagescheck missingImagesCheck  o  ���� &0 missingfontscheck missingFontsCheck � o  ���� 0 i  �  �'  �  f  ���)  � m  ���
� boovtrue� k  ��		 

 l ����   n h> If the createPDF returns true, the destilling was a success so we set the icon in the NSTabel to green    � r  �� I ����
� .appSloaInull���    obj  m  ��  	ico_green   �   n       1  ���
� 
pcnt n  �� 4  ���
� 
datC m  �� 
 icon    n  �� 4  ���
� 
datR o  ���� 0 i   o  ����  0 filelistsource fileListSource�  �*  � k  ��  l ����   m g> If the createPDF returns false, the destilling was a failure so we set the icon in the NSTabel to red    � r  �� !  I ���"�
� .appSloaInull���    obj " m  ��##  ico_red   �  ! n      $%$ 1  ���
� 
pcnt% n  ��&'& 4  ���(
� 
datC( m  ��)) 
 icon   ' n  ��*+* 4  ���,
� 
datR, o  ���
�
 0 i  + o  ���	�	  0 filelistsource fileListSource�  �+  �p 0 i  s m  ���� t o  ���� 0 
numoffiles 
numOfFiles�o  q -.- l �����  �  . /0/ l ���1�  1 1 +> Since we are done, close the status panel   0 2�2 I ���3�
� .panScloPnull���    obj 3 4  ��� 4
�  
cwin4 m  ��55  progressPanel   �  �  ��  ��  b 676 l ��������  ��  7 8��8 l ����9��  9 < 6#### If the Options selected  button is pressed ####--   ��   :;: = ��<=< n  ��>?> 1  ����
�� 
ideT? o  ������ 0 	theobject 	theObject= m  ��@@  options item identifier   ; ABA k  }CC DED l ��F��  F + %> Set the cirrent state of the drawer   E GHG r  IJI n  KLK 1  ��
�� 
staBL n  MNM 4  ��O
�� 
draAO m  PP  drawer   N 4  ��Q
�� 
cwinQ m  RR 
 main   J o      ���� (0 currentdrawerstate currentDrawerStateH STS l ��U��  U 6 0> If the drawer is closed open it and vice versa   T VWV Z  {XYZ��X G  -[\[ = ]^] o  ���� (0 currentdrawerstate currentDrawerState^ m  ��
�� EDrEdrCS\ = ")_`_ o  "%���� (0 currentdrawerstate currentDrawerState` m  %(��
�� EDrEdrCTY O 0Faba I @E������
�� .caVSopeDnull���    obj ��  ��  b n  0=cdc 4  6=��e
�� 
draAe m  9<ff  drawer   d 4  06��g
�� 
cwing m  25hh 
 main   Z iji G  I^klk = IPmnm o  IL���� (0 currentdrawerstate currentDrawerStaten m  LO��
�� EDrEdrOTl = SZopo o  SV���� (0 currentdrawerstate currentDrawerStatep m  VY��
�� EDrEdrOSj q��q O awrsr I qv������
�� .caVScloDnull���    obj ��  ��  s n  antut 4  gn��v
�� 
draAv m  jmww  drawer   u 4  ag��x
�� 
cwinx m  cfyy 
 main   ��  ��  W z{z l ||������  ��  { |��| l ||��}��  } ; 5#### If the Remove selected  button is pressed ####--   ��  B ~~ = ����� n  ����� 1  ����
�� 
ideT� o  ������ 0 	theobject 	theObject� m  ����  remove item identifier    ��� k  ���� ��� l �������  � < 6> Call function to remove selected items from the list   � ��� n ����� I  ����������  0 removeselected removeSelected��  ��  �  f  ��� ��� l ��������  ��  � ���� l �������  � 5 /#### If the Remove all button is pressed ####--   ��  � ��� = ����� n  ����� 1  ����
�� 
ideT� o  ������ 0 	theobject 	theObject� m  ����  removeAll item identifier   � ��� k  ���� ��� l �������  � 7 1> Call function to remove all items from the list   � ��� n ����� I  ���������� 0 	removeall 	removeAll��  ��  �  f  ��� ��� l ��������  ��  � ���� l �������  � < 6#### If the Check errorbutton button is pressed ####--   ��  � ��� = ����� n  ����� 1  ����
�� 
ideT� o  ������ 0 	theobject 	theObject� m  ����  check errors identifier   � ���� k  �R�� ��� l �������  � @ :> Call function to check errors in all items from the list   � ��� l ��������  ��  � ��� l �������  � ( "#### Open the prgress panel ####--   � ��� l �������  � ? 9> Open the progressbar window attached to the main window   � ��� I ������
�� .panSdisQnull���    obj � 4  �����
�� 
cwin� m  ����  progressPanel   � �����
�� 
attT� 4  �����
�� 
cwin� m  ���� 
 main   ��  � ��� O ����� r  ����� m  ����
�� boovfals� 1  ����
�� 
indR� n  ����� 4  �����
�� 
proI� m  ����  progress   � 4  �����
�� 
cwin� m  ����  progressPanel   � ��� l ��������  ��  � ��� l �������  � C =#### Set the datasources for the values in the NSTable ####--   � ��� l �������  � G A>Create a new datasource containing all the files in the NSTable.   � ��� r  ����� n  ����� m  ����
�� 
datS� n  ����� 4  �����
�� 
tabW� m  ����  fileList   � n  ����� 4  �����
�� 
scrV� m  ����  files   � 4  �����
�� 
cwin� m  ���� 
 main   � o      ����  0 filelistsource fileListSource� ��� l �������  � ? 9> Retrive the complete paths & filenames from the NSTable   � ��� r  ���� n  ���� 1  ��
�� 
pcnt� n  ���� 4  ���
�� 
datC� m  �� 
 path   � n  ���� 2 ��
�� 
datR� n  ���� m  ��
�� 
datS� n  ���� 4  ����
�� 
tabW� m   ��  fileList   � n  ����� 4  ���� 
�� 
scrV  m  ��  files   � 4  ����
�� 
cwin m  �� 
 main   � o      ���� 0 thepaths thePaths�  r  7 n  5	 1  15��
�� 
pcnt	 n  1

 4  *1��
�� 
datC m  -0  files    n  * 2 (*��
�� 
datR n  ( m  &(��
�� 
datS n  & 4  !&��
�� 
tabW m  "%  fileList    n  ! 4  !��
�� 
scrV m     files    4  ��
�� 
cwin m   
 main    o      ���� 0 thefiles theFiles  l 88������  ��    l 88�� ��    : 4#### Count the number of pages in the NSTabel ####--    !"! l 88��#��  # . (> Set the number of files in the NSTable   " $%$ r  8P&'& n  8N()( m  LN��
�� 
nmbr) n  8L*+* 2 JL��
�� 
datR+ n  8J,-, m  HJ��
�� 
datS- n  8H./. 4  CH��0
�� 
tabW0 m  DG11  fileList   / n  8C232 4  >C��4
�� 
scrV4 m  ?B55  files   3 4  8>��6
�� 
cwin6 m  :=77 
 main   ' o      ���� 0 
numoffiles 
numOfFiles% 898 l QQ������  ��  9 :;: l QQ��<��  < 3 -> Set up a default value for the error result   ; =>= r  QV?@? m  QR��
�� boovtrue@ o      ���� 0 errorresult errorResult> ABA l WW������  ��  B CDC l WW��E��  E Z T> Count up all the pages to be destilled, this will be used to make the progressbar    D FGF Y  WEH��IJ��H k  a@KK LML l aa��N��  N Y S> For each loop the var totalPages equals the previous totalPages pluss the current   M OPO r  auQRQ c  aqSTS b  amUVU o  ad���� 0 	startdisk 	startDiskV n  dlWXW 4  el��Y
�� 
cobjY o  hk���� 0 error_i  X o  de���� 0 thepaths thePathsT m  mp��
�� 
TEXTR o      ���� 0 open_document  P Z[Z l vv��\��  \ \ V> Indesign does not understand the "/" delimiters, so we need to replace them with ":"   [ ]^] r  v�_`_ c  v�aba l v~c�c n v~ded I  w~�~f�}�~ 0 makecolonpath makeColonpathf g�|g o  wz�{�{ 0 open_document  �|  �}  e  f  vw�  b m  ~��z
�z 
TEXT` o      �y�y 0 open_document  ^ hih l ���x�w�x  �w  i jkj l ���vl�v  l 4 .> Get the number of characters in the filename   k mnm r  ��opo c  ��qrq n  ��sts m  ���u
�u 
nmbrt n  ��uvu 2 ���t
�t 
cha v n  ��wxw 4  ���sy
�s 
cobjy o  ���r�r 0 error_i  x o  ���q�q 0 thefiles theFilesr m  ���p
�p 
nmbrp o      �o�o 0 length_filename  n z{z l ���n|�n  | N H> Remove the filename from the filepath to get path to the parent folder   { }~} r  ��� c  ����� b  ����� o  ���m�m 0 	startdisk 	startDisk� l ����l� n  ����� 7 ���k��
�k 
cha � m  ���j�j � l ����i� \  ����� l ����h� n  ����� m  ���g
�g 
nmbr� n  ����� 2 ���f
�f 
cha � n  ����� 4  ���e�
�e 
cobj� o  ���d�d 0 error_i  � o  ���c�c 0 thepaths thePaths�h  � o  ���b�b 0 length_filename  �i  � n  ����� 4  ���a�
�a 
cobj� o  ���`�` 0 error_i  � o  ���_�_ 0 thepaths thePaths�l  � m  ���^
�^ 
TEXT� o      �]�] 0 
savefolder 
saveFolder~ ��� l ���\��\  � * $> Create a colon separeted filepath    � ��� r  ����� c  ����� l ����[� n ����� I  ���Z��Y�Z 0 makecolonpath makeColonpath� ��X� o  ���W�W 0 
savefolder 
saveFolder�X  �Y  �  f  ���[  � m  ���V
�V 
TEXT� o      �U�U 0 
savefolder 
saveFolder� ��� l ���T�S�T  �S  � ��� l ���R��R  �  > Open InDesign   � ��� O  ���� k  ��� ��� l ���Q��Q  � r l> Make a new document object, the "without showing window" will set user interaction level to never interact   � ��� r  ����� I ���P��
�P .aevtodocnull  �    alis� o  ���O�O 0 open_document  � �N��M
�N 
psiw� m  ���L
�L boovfals�M  � o      �K�K "0 currentdocument currentDocument� ��� l ���J�I�J  �I  � ��� l ���H��H  � 8 2> Check the documents for missing images and fonts   � ��� Z  �
���G�F� = ����� l ����E� n ����� I  ���D��C�D 0 
checkerror 
checkError� ��� o  ���B�B "0 currentdocument currentDocument� ��� o  ���A�A 0 
savefolder 
saveFolder� ��� m  ���@
�@ boovtrue� ��?� m  ���>
�> boovtrue�?  �C  �  f  ���E  � m  ���=
�= boovfals� k  �� ��� l �<��<  � . (> Set the result of errorCheck to a bool   � ��;� r  ��� m  �:
�: boovfals� o      �9�9 0 errorresult errorResult�;  �G  �F  � ��� l �8�7�8  �7  � ��� l �6��6  �  > Close the document   � ��5� O ��� I �4�3�2
�4 .CoReclosnull���     obj �3  �2  � o  �1�1 "0 currentdocument currentDocument�5  � m  ��|� ��� l �0�/�0  �/  � ��� l �.��.  � J D> If there are any error in the document, we need to label it as red   � ��� Z  >���-�,� = ��� o  �+�+ 0 errorresult errorResult� m  �*
�* boovtrue� r  !:��� I !(�)��(
�) .appSloaInull���    obj � m  !$��  ico_red   �(  � n      ��� 1  59�'
�' 
pcnt� n  (5��� 4  .5�&�
�& 
datC� m  14�� 
 icon   � n  (.��� 4  ).�%�
�% 
datR� o  *-�$�$ 0 error_i  � o  ()�#�#  0 filelistsource fileListSource�-  �,  � ��"� l ??�!� �!  �   �"  �� 0 error_i  I m  Z[�� J o  [\�� 0 
numoffiles 
numOfFiles��  G ��� l FF���  �  � ��� l FF���  � 1 +> Since we are done, close the status panel   � ��� I FP���
� .panScloPnull���    obj � 4  FL� 
� 
cwin  m  HK  progressPanel   �  � � l QQ���  �  �  ��  �q  �r  �  l     ���  �    l     ��   k e#### This event handler is called whenever the state of the toolbar items needs to be changed. ####--    	 i    

 I     ��
� .appSupTInull���    obj  o      �� 0 	theobject 	theObject�   k       l     ��   [ U> We return true in order to enable the toolbar item, otherwise we would return false    � L      m     �
� boovtrue�  	  l     ��
�  �
    l     �	��	  �    l     ��    ##################--     l     ��    ##### UI OBJECTS #####--     l     ��    ##################--     !  l     ���  �  ! "#" l     �$�  $ q k#### This event handler is called whenever object from the UI attached to this as-file is is clicked ####--   # %&% i    '(' I     �)� 
� .coVScliInull���    obj ) o      ���� 0 	theobject 	theObject�   ( k     �** +,+ l     ��-��  - 5 /> Set the name of the object thats been clicked   , ./. r     010 c     232 n     454 1    ��
�� 
pnam5 o     ���� 0 	theobject 	theObject3 m    ��
�� 
TEXT1 o      ���� $0 objectidentifier objectIdentifier/ 676 l   ������  ��  7 898 l   ��:��  : d ^#### If the cb_baseName is clicked, we need to update the editable state of tf_baseName ####--   9 ;��; Z    �<=>��< =   ?@? o    	���� $0 objectidentifier objectIdentifier@ m   	 
AA  cb_baseName   = k    _BB CDC l   ��E��  E 7 1> Set the value of cb_baseName as a boolean value   D FGF r    !HIH c    JKJ n    LML 1    ��
�� 
pcntM n    NON 4    ��P
�� 
butTP m    QQ  cb_baseName   O n    RSR 4    ��T
�� 
boxOT m    UU  options   S n    VWV 4    ��X
�� 
draAX m    YY  drawer   W 4    ��Z
�� 
cwinZ m    [[ 
 main   K m    ��
�� 
boolI o      ���� 0 basenamecheck baseNameCheckG \]\ l  " "��^��  ^ c ]> With the result returned from the value of cb_baseName make the tf_baseName editable or not   ] _`_ Z   " ]ab��ca o   " #���� 0 basenamecheck baseNameCheckb r   & =ded m   & '��
�� boovtruee n      fgf 1   8 <��
�� 
ediTg n   ' 8hih 4   1 8��j
�� 
texFj m   4 7kk  tf_baseName   i n   ' 1lml 4   . 1��n
�� 
boxOn m   / 0oo  options   m n   ' .pqp 4   + .��r
�� 
draAr m   , -ss  drawer   q 4   ' +��t
�� 
cwint m   ) *uu 
 main   ��  c r   @ ]vwv m   @ A��
�� boovfalsw n      xyx 1   X \��
�� 
ediTy n   A Xz{z 4   Q X��|
�� 
texF| m   T W}}  tf_baseName   { n   A Q~~ 4   L Q���
�� 
boxO� m   M P��  options    n   A L��� 4   G L���
�� 
draA� m   H K��  drawer   � 4   A G���
�� 
cwin� m   C F�� 
 main   ` ��� l  ^ ^������  ��  � ���� l  ^ ^�����  � r l#### If the cb_extractPages is clicked, we need to update the editable state of rg_extractPagesSuffix ####--   ��  > ��� =  b g��� o   b c���� $0 objectidentifier objectIdentifier� m   c f��  cb_extractPages   � ���� k   j ��� ��� l  j j�����  � ; 5> Set the value of cb_extractPages as a boolean value   � ��� r   j ���� c   j ���� n   j ���� 1    ���
�� 
pcnt� n   j ��� 4   z ���
�� 
butT� m   { ~��  cb_extractPages   � n   j z��� 4   u z���
�� 
boxO� m   v y��  options   � n   j u��� 4   p u���
�� 
draA� m   q t��  drawer   � 4   j p���
�� 
cwin� m   l o�� 
 main   � m   � ���
�� 
bool� o      ���� &0 extractpagescheck extractPagesCheck� ��� l  � ������  � q k> With the result returned from the value of cb_extractPages make the rg_extractPagesSuffix editable or not   � ���� Z   � ������� o   � ����� &0 extractpagescheck extractPagesCheck� r   � ���� m   � ���
�� boovtrue� n      ��� 1   � ���
�� 
enaB� n   � ���� 4   � ����
�� 
matT� m   � ���  rg_extractPagesSuffix   � n   � ���� 4   � ����
�� 
boxO� m   � ���  options   � n   � ���� 4   � ����
�� 
draA� m   � ���  drawer   � 4   � ����
�� 
cwin� m   � ��� 
 main   ��  � r   � ���� m   � ���
�� boovfals� n      ��� 1   � ���
�� 
enaB� n   � ���� 4   � ����
�� 
matT� m   � ���  rg_extractPagesSuffix   � n   � ���� 4   � ����
�� 
boxO� m   � ���  options   � n   � ���� 4   � ����
�� 
draA� m   � ���  drawer   � 4   � ����
�� 
cwin� m   � ��� 
 main   ��  ��  ��  ��  & ��� l     ������  ��  � ��� l     ������  ��  � ��� l     �����  �  ##################--   � ��� l     �����  �  ##### MAIN MENU #####--   � ��� l     �����  �  ##################--   � ��� l     ������  ��  � ��� l     �����  � 4 .#### Actions for ALL menu items go here ####--   � ��� i    ��� I     �����
�� .menSchMInull���    obj � o      ���� 0 	theobject 	theObject��  � k     ��� ��� l     �����  � ; 5> Set the name of the menu object thats been selected   � ��� r     ��� c     ��� n     ��� 1    ��
�� 
titl� o     ���� 0 	theobject 	theObject� m    ��
�� 
TEXT� o      ����  0 menuidentifier menuIdentifier� ��� l   ������  ��  � ���� Z    ����	 � =   			 o    	����  0 menuidentifier menuIdentifier	 m   	 
		  Preferences   � k    		 			 I   ��		
�� .appSshoHnull���    obj 	 4    ��		
�� 
cwin		 m    	
	
  preferences   	 ��	��
�� 
inFO	 4    ��	
�� 
cwin	 m    		 
 main   ��  	 			 l   ������  ��  	 	��	 l   ��	��  	 9 3#### If the Remove selected menu is selected ####--   ��  � 			 =    #			 o     !����  0 menuidentifier menuIdentifier	 m   ! "		  Remove   	 			 k   & -		 			 l  & &��	��  	 < 6> Call function to remove selected items from the list   	 			 n  & +		 	 I   ' +��������  0 removeselected removeSelected��  ��  	   f   & '	 	!	"	! l  , ,������  ��  	" 	#��	# l  , ,��	$��  	$ 4 .#### If the Remove all menu is selected ####--   ��  	 	%	&	% =  0 3	'	(	' o   0 1����  0 menuidentifier menuIdentifier	( m   1 2	)	)  
Remove all   	& 	*	+	* k   6 =	,	, 	-	.	- l  6 6��	/��  	/ 7 1> Call function to remove all items from the list   	. 	0	1	0 n  6 ;	2	3	2 I   7 ;�������� 0 	removeall 	removeAll��  ��  	3  f   6 7	1 	4	5	4 l  < <������  ��  	5 	6	7	6 l  < <������  ��  	7 	8	9	8 l   < <��	:��  	: Z T
		
		This code was excluded due to a bug when trying to re open the main window.
		   	9 	;��	; l  < <��	<��  	< . (#### If the xPDF menu is selected ####--   ��  	+ 	=	>	= =  @ C	?	@	? o   @ A����  0 menuidentifier menuIdentifier	@ m   A B	A	A 
 xPDF   	> 	B	C	B k   F V	D	D 	E	F	E l  F F��	G��  	G ^ X> Because the window unloads from the memory when closed, we need to reload the nib file   	F 	H	I	H I  F K��	J��
�� .appSloaNnull���    obj 	J m   F G	K	K  MainMenu   ��  	I 	L	M	L l  L L��	N��  	N ( "> Now we can show the window again   	M 	O	P	O I  L T��	Q��
�� .appSshoHnull���    obj 	Q 4   L P��	R
�� 
cwin	R m   N O	S	S 
 main   ��  	P 	T	U	T l  U U������  ��  	U 	V��	V l  U U�	W�  	W 8 2#### If the Online Support menu is selected ####--   ��  	C 	X	Y	X =  Y ^	Z	[	Z o   Y Z�~�~  0 menuidentifier menuIdentifier	[ m   Z ]	\	\  Online support   	Y 	]�}	] k   a �	^	^ 	_	`	_ l  a a�|	a�|  	a d ^> Do a try statement to open Safari, if that dosent work, display a message with the webadress   	` 	b�{	b Q   a �	c	d	e	c O   d x	f	g	f k   j w	h	h 	i	j	i l  j j�z	k�z  	k ! > Bring safari to the front   	j 	l	m	l I  j o�y�x�w
�y .miscactvnull��� ��� null�x  �w  	m 	n	o	n l  p p�v	p�v  	p  > Open the webpage   	o 	q�u	q I  p w�t	r�s
�t .GURLGURLnull��� ��� TEXT	r m   p s	s	s ' !http://www.creatordesign.no/xpdf/   �s  �u  	g m   d g	t	t�null     ߀��  �
Safari.app the webadressitable or not-���     6���$ � `�/��  sfri   alis    L  Macintosh HD               �F�
H+    �
Safari.app                                                      [|m���P        ����  	                Applications    �F��      ���@      �  $Macintosh HD:Applications:Safari.app   
 S a f a r i . a p p    M a c i n t o s h   H D  Applications/Safari.app   / ��  	d R      �r�q�p
�r .ascrerr ****      � ****�q  �p  	e k   � �	u	u 	v	w	v l  � ��o	x�o  	x : 4> If Safari is'nt found we need to display a message   	w 	y�n	y I  � ��m	z	{
�m .panSdisAnull���    obj 	z m   � �	|	|  Sorry...   	{ �l	}	~
�l 
as A	} m   � ��k
�k EAlTwarN	~ �j		�
�j 
mesS	 b   � �	�	�	� b   � �	�	�	� m   � �	�	� ! Try visiting our webpage at   	� l  � �	��i	� I  � ��h	��g
�h .sysontocTEXT       shor	� m   � ��f�f 
�g  �i  	� m   � �	�	� ' !http://www.creatordesign.no/xpdf/   	� �e	�	�
�e 
defB	� m   � �	�	�  Ok   	� �d	��c
�d 
attT	� 4   � ��b	�
�b 
cwin	� m   � �	�	� 
 main   �c  �n  �{  �}  	  k   � �	�	� 	�	�	� l  � ��a	��a  	� I C> It the script arrives here we check if our dropdown menu was used   	� 	�	�	� l  � ��`	��`  	� p j> The scope of the list PDFpresetList set in awaken nib can't be accessed from here so we need to reset it   	� 	�	�	� O   � �	�	�	� r   � �	�	�	� c   � �	�	�	� n   � �	�	�	� 1   � ��_
�_ 
pnam	� 2   � ��^
�^ 
PFst	� m   � ��]
�] 
list	� o      �\�\ 0 pdfpresetlist PDFpresetList	� m   � �|	� 	�	�	� l  � ��[	��[  	� F @> Loop the of presets man match against the list is in the menu    	� 	��Z	� X   � �	��Y	�	� Z   � �	�	��X�W	� =  � �	�	�	� c   � �	�	�	� o   � ��V�V $0 currentpdfpreset currentPDFpreset	� m   � ��U
�U 
ctxt	� o   � ��T�T  0 menuidentifier menuIdentifier	� k   � �	�	� 	�	�	� l  � ��S	��S  	� D >> Function for updateing the info in the summary box goes here   	� 	��R	� n  � �	�	�	� I   � ��Q	��P�Q  0 updatedsummary updatedSummary	� 	��O	� o   � ��N�N $0 currentpdfpreset currentPDFpreset�O  �P  	�  f   � ��R  �X  �W  �Y $0 currentpdfpreset currentPDFpreset	� o   � ��M�M 0 pdfpresetlist PDFpresetList�Z  ��  � 	�	�	� l     �L�K�L  �K  	� 	�	�	� l     �J�I�J  �I  	� 	�	�	� l     �H	��H  	�  ################--   	� 	�	�	� l     �G	��G  	�  #### FUNCTIONS ####--   	� 	�	�	� l     �F	��F  	�  ################--   	� 	�	�	� l     �E�D�E  �D  	� 	�	�	� l     �C	��C  	� 1 +#### Create PDF of indesign document ####--   	� 	�	�	� l     �B	��B  	� S M> openDocument is a string that must be the full path to the document to open   	� 	�	�	� l     �A	��A  	� A ;> saveFolder is a string to the folder the file is saved to   	� 	�	�	� l     �@	��@  	� E ?> PDFExportPreset is a sting woth the name of the preset to use   	� 	�	�	� l     �?	��?  	� " > baseNameCheck is a boolean   	� 	�	�	� l     �>	��>  	� = 7> baseNameText is a string containing the basename text   	� 	�	�	� l     �=	��=  	� &  > extractPagesCheck is a boolean   	� 	�	�	� l     �<	��<  	� ( "> extractPagesType is a number 1,2   	� 	�	�	� l     �;	��;  	� ' !> missingImagesCheck is a boolean   	� 	�	�	� l     �:	��:  	� &  > missingFontsCheck is a boolean   	� 	�	�	� l     �9	��9  	�  > incremental is a number   	� 	�	�	� l     �8�7�8  �7  	� 	�	�	� l     �6	��6  	� O I> Returns: true | false based on the success of the creation of the files   	� 	�	�	� l     �5�4�5  �4  	� 	�	�	� i    	�	�	� I      �3	��2�3 0 	createpdf 	createPDF	� 	�	�	� o      �1�1 0 opendocument openDocument	� 	�	�	� o      �0�0 0 
savefolder 
saveFolder	� 	�	�	� o      �/�/ "0 pdfexportpreset PDFExportPreset	� 	�	�	� o      �.�. 0 basenamecheck baseNameCheck	� 	�	�	� o      �-�- 0 basenametext baseNameText	� 	�	�	� o      �,�, &0 extractpagescheck extractPagesCheck	� 	�	�	� o      �+�+ $0 extractpagestype extractPagesType	� 	�
 	� o      �*�* (0 missingimagescheck missingImagesCheck
  


 o      �)�) &0 missingfontscheck missingFontsCheck
 
�(
 o      �'�' 0 incremental  �(  �2  	� k    i

 


 l     �&
�&  
  > Open InDesign CS2   
 

	
 O    f




 k   e

 


 l   �%�$�%  �$  
 


 l   �#
�#  
 r l> Make a new document object, the "without showing window" will set user interaction level to never interact   
 


 r    


 I   �"


�" .aevtodocnull  �    alis
 o    �!�! 0 opendocument openDocument
 � 
�
�  
psiw
 m    �
� boovfals�  
 o      �� "0 currentdocument currentDocument
 


 l   ���  �  
 


 l   �
�  
 + %> Update the text in the status panel   
 


 n   
 
!
  I    �
"�� *0 updatestatusmessage updateStatusMessage
" 
#�
# b    
$
%
$ m    
&
&  
Exporting    
% n    
'
(
' 1    �
� 
pnam
( o    �� "0 currentdocument currentDocument�  �  
!  f    
 
)
*
) l   ���  �  
* 
+
,
+ l   �
-�  
- U O> If any of the check error messages are true then call the checkError function   
, 
.
/
. Z    H
0
1��
0 G    "
2
3
2 o    �� (0 missingimagescheck missingImagesCheck
3 =    
4
5
4 o    �� &0 missingfontscheck missingFontsCheck
5 m    �
� boovtrue
1 Z   % D
6
7��
6 =  % 0
8
9
8 l  % .
:�

: n  % .
;
<
; I   & .�	
=��	 0 
checkerror 
checkError
= 
>
?
> o   & '�� "0 currentdocument currentDocument
? 
@
A
@ o   ' (�� 0 
savefolder 
saveFolder
A 
B
C
B o   ( )�� (0 missingimagescheck missingImagesCheck
C 
D�
D o   ) *�� &0 missingfontscheck missingFontsCheck�  �  
<  f   % &�
  
9 m   . /�
� boovtrue
7 k   3 @
E
E 
F
G
F l  3 3�
H�  
H d ^> If any errors occur, we need to close the document here, before we return the function false   
G 
I
J
I O  3 =
K
L
K I  7 <� ����
�  .CoReclosnull���     obj ��  ��  
L o   3 4���� "0 currentdocument currentDocument
J 
M��
M L   > @
N
N m   > ?��
�� boovfals��  �  �  �  �  
/ 
O
P
O l  I I������  ��  
P 
Q
R
Q l  I I��
S��  
S S M> The document wil take several directions based on the options from the user   
R 
T
U
T l  I I��
V��  
V I C> This is the first crossroad and is based on the extractPagesCheck   
U 
W
X
W Z   IZ
Y
Z��
[
Y o   I J���� &0 extractpagescheck extractPagesCheck
Z k   Mw
\
\ 
]
^
] Y   Mi
_��
`
a��
_ k   ]d
b
b 
c
d
c l  ] ]��
e��  
e - '> Check what kind of incremental to use   
d 
f
g
f Z   ] w
h
i��
j
h =  ] `
k
l
k o   ] ^���� $0 extractpagestype extractPagesType
l m   ^ _���� 
i k   c j
m
m 
n
o
n l  c c��
p��  
p / )> If extractPagesType is set to 1 we use    
o 
q
r
q l  c c��
s��  
s 1 +> the incremental passed allong the repeat    
r 
t
u
t l  c c��
v��  
v 6 0> pluss the number of pages in the preious file.   
u 
w��
w r   c j
x
y
x c   c h
z
{
z l  c f
|��
| [   c f
}
~
} o   c d���� 
0 page_i  
~ o   d e����  0 runincremental runIncremental��  
{ m   f g��
�� 
nmbr
y o      ���� 0 incremental  ��  ��  
j k   m w

 
�
�
� l  m m��
���  
� T N> If the extractPagesType is set to 2, it means we need to use the pagenumber    
� 
�
�
� l  m m��
���  
� ? 9> and not the incremental passes allong with the function   
� 
���
� r   m w
�
�
� c   m u
�
�
� n   m s
�
�
� 1   q s��
�� 
pnam
� n   m q
�
�
� 4   n q��
�
�� 
page
� o   o p���� 
0 page_i  
� o   m n���� "0 currentdocument currentDocument
� m   s t��
�� 
nmbr
� o      ���� 0 incremental  ��  
g 
�
�
� l  x x������  ��  
� 
�
�
� l  x x��
���  
� M G> If the incremental is smaler than 10 we add a leading 0 to the number   
� 
�
�
� Z   x �
�
�����
� o   x y���� "0 prefleadingzero prefLeadingZero
� Z   | �
�
�����
� A  | 
�
�
� o   | }���� 0 incremental  
� m   } ~���� 

� r   � �
�
�
� b   � �
�
�
� m   � �
�
�  0   
� o   � ����� 0 incremental  
� o      ���� 0 incremental  ��  ��  ��  ��  
� 
�
�
� l  � �������  ��  
� 
�
�
� l  � ���
���  
� > 8> Build the filename based on the value of baseNameCheck   
� 
�
�
� Z   � �
�
���
�
� o   � ����� 0 basenamecheck baseNameCheck
� k   � �
�
� 
�
�
� l  � ���
���  
� M G> Use the basenametext enterd and the incremental to build the fileName   
� 
���
� r   � �
�
�
� c   � �
�
�
� b   � �
�
�
� o   � ����� 0 basenametext baseNameText
� o   � ����� 0 incremental  
� m   � ���
�� 
TEXT
� o      ���� 0 filename fileName��  ��  
� k   � �
�
� 
�
�
� l  � ���
���  
� V P> Use the name of the current document and the incremental to build the fileName   
� 
�
�
� r   � �
�
�
� c   � �
�
�
� n   � �
�
�
� 1   � ���
�� 
pnam
� o   � ����� "0 currentdocument currentDocument
� m   � ���
�� 
TEXT
� o      ���� 0 filename fileName
� 
�
�
� l  � �������  ��  
� 
�
�
� l  � ���
���  
� * $> Remove extension from the fileName   
� 
�
�
� r   � �
�
�
� l  � �
���
� n   � �
�
�
� m   � ���
�� 
nmbr
� n   � �
�
�
� 2  � ���
�� 
cha 
� l  � �
���
� o   � ����� 0 filename fileName��  ��  
� o      ���� 0 length_extension  
� 
�
�
� r   � �
�
�
� c   � �
�
�
� l  � �
���
� \   � �
�
�
� o   � ����� 0 length_extension  
� m   � ����� ��  
� m   � ���
�� 
TEXT
� o      ���� 0 start_extesion  
� 
���
� r   � �
�
�
� c   � �
�
�
� b   � �
�
�
� l  � �
���
� n   � �
�
�
� 7  � ���
�
�
�� 
cha 
� m   � ����� 
� o   � ����� 0 start_extesion  
� l  � �
���
� o   � ����� 0 filename fileName��  ��  
� o   � ����� 0 incremental  
� m   � ���
�� 
TEXT
� o      ���� 0 filename fileName��  
� 
�
�
� l  � �������  ��  
� 
�
�
� l  � ���
���  
� - '> Update the text in the status message   
� 
�
�
� n  � �
�
�
� I   � ���
����� *0 updatestatusmessage updateStatusMessage
� 
���
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� b   � �
�
�
� m   � �
�
�  
Exporting    
� n   � �
�
�
� 1   � ���
�� 
pnam
� o   � ����� "0 currentdocument currentDocument
� m   � �    , page    
� o   � ����� 
0 page_i  
� m   � � 
  of    
� l  � ��� I  � �����
�� .corecnte****       **** n  � � 2  � ���
�� 
page o   � ����� "0 currentdocument currentDocument��  ��  ��  ��  
�  f   � �
�  l  � �������  ��   	 l  � ���
��  
 0 *>Set the range of the pages to be exported   	  r   � n   � � 1   � ���
�� 
pnam n   � � 4   � ���
�� 
page o   � ����� 
0 page_i   o   � ����� "0 currentdocument currentDocument n       1  ��
�� 
pcty 1   ���
�� 
DFpf  l ������  ��    l ����   G A> Increase the progressbar by 1 because only on pages is exported     n  I  	������ *0 increaseprogressbar increaseProgressBar  ��  m  	
���� ��  ��    f  	 !"! l ������  ��  " #$# l ��%��  % J D> If prefReplaceFiles is set to false we're allowd  to replace files   $ &'& Z  b()��*( = "+,+ l  -��- n  ./. I   ��0���� 0 
fileexists 
fileExists0 121 o  ���� 0 
savefolder 
saveFolder2 343 o  ���� 0 filename fileName4 565 c  787 n  9:9 1  ��
�� 
pnam: o  ���� "0 currentdocument currentDocument8 m  �
� 
TEXT6 ;�~; o  �}�} $0 prefreplacefiles prefReplaceFiles�~  ��  /  f  ��  , m   !�|
�| boovfals) k  %R<< =>= l %%�{?�{  ? n h> Because the default timeout of Applescript is set to timeout after one minute we need to increase this   > @�z@ t  %RABA k  -QCC DED l --�yF�y  F  > Export the page as pdf   E G�xG O  -QHIH I 1P�w�vJ
�w .K2  exptnull���     docu�v  J �uKL
�u 
exftK m  58�t
�t eXftt_PDL �sMN
�s 
kfilM l ;BO�rO b  ;BPQP b  ;>RSR o  ;<�q�q 0 
savefolder 
saveFolderS o  <=�p�p 0 filename fileNameQ m  >ATT 
 .pdf   �r  N �oUV
�o 
usngU o  EF�n�n "0 pdfexportpreset PDFExportPresetV �mW�l
�m 
imotW m  IJ�k
�k boovfals�l  I o  -.�j�j "0 currentdocument currentDocument�x  B l %,X�iX ]  %,YZY o  %(�h�h &0 prefscripttimeout prefScriptTimeoutZ m  (+�g�g <�i  �z  ��  * k  Ub[[ \]\ l UU�f^�f  ^  > Close the document   ] _`_ O U_aba I Y^�e�d�c
�e .CoReclosnull���     obj �d  �c  b o  UV�b�b "0 currentdocument currentDocument` c�ac L  `bdd m  `a�`
�` boovfals�a  ' e�_e l cc�^�]�^  �]  �_  �� 
0 page_i  
` m   P Q�\�\ 
a l  Q Xf�[f I  Q X�Zg�Y
�Z .corecnte****       ****g n  Q Thih 2  R T�X
�X 
pagei o   Q R�W�W "0 currentdocument currentDocument�Y  �[  ��  
^ jkj l jj�V�U�V  �U  k lml l jj�Tn�T  n m g> Here we need to set the global runIncremental to itself + the number of pages in the current document   m opo r  juqrq [  jssts o  jk�S�S  0 runincremental runIncrementalt l kru�Ru I kr�Qv�P
�Q .corecnte****       ****v n knwxw 2 ln�O
�O 
pagex o  kl�N�N "0 currentdocument currentDocument�P  �R  r o      �M�M  0 runincremental runIncrementalp y�Ly l vv�K�J�K  �J  �L  ��  
[ k  zZzz {|{ l zz�I}�I  } 1 +> When here we do not need to extract pages   | ~~ l zz�H�G�H  �G   ��� l zz�F��F  � M G> If the incremental is smaler than 10 we add a leading 0 to the number   � ��� l zz�E��E  � f `> Because we don't need to extract any pages we can use the intremental passed with the function   � ��� Z  z����D�C� o  z{�B�B "0 prefleadingzero prefLeadingZero� Z  ~����A�@� A ~���� o  ~�?�? 0 incremental  � m  ��>�> 
� r  ����� b  ����� m  ����  0   � o  ���=�= 0 incremental  � o      �<�< 0 incremental  �A  �@  �D  �C  � ��� l ���;�:�;  �:  � ��� l ���9��9  � > 8> Build the filename based on the value of baseNameCheck   � ��� Z  �����8�� o  ���7�7 0 basenamecheck baseNameCheck� k  ���� ��� l ���6��6  � M G> Use the basenametext enterd and the incremental to build the fileName   � ��5� r  ����� c  ����� b  ����� o  ���4�4 0 basenametext baseNameText� o  ���3�3 0 incremental  � m  ���2
�2 
TEXT� o      �1�1 0 filename fileName�5  �8  � k  ���� ��� l ���0��0  � . (> Use the name of the current document.    � ��� l ���/��/  � ^ X> We don't add any incremental here, because the filenames ar likely to have uniqe names   � ��� r  ����� c  ����� n  ����� 1  ���.
�. 
pnam� o  ���-�- "0 currentdocument currentDocument� m  ���,
�, 
TEXT� o      �+�+ 0 filename fileName� ��� l ���*�)�*  �)  � ��� l ���(��(  � * $> Remove extension from the fileName   � ��� r  ����� l ����'� n  ����� m  ���&
�& 
nmbr� n  ����� 2 ���%
�% 
cha � l ����$� o  ���#�# 0 filename fileName�$  �'  � o      �"�" 0 length_extension  � ��� r  ����� c  ����� l ����!� \  ����� o  ��� �  0 length_extension  � m  ���� �!  � m  ���
� 
TEXT� o      �� 0 start_extesion  � ��� r  ����� c  ����� l ����� n  ����� 7 �����
� 
cha � m  ���� � o  ���� 0 start_extesion  � l ����� o  ���� 0 filename fileName�  �  � m  ���
� 
TEXT� o      �� 0 filename fileName�  � ��� l �����  �  � ��� l �����  � - '> Update the text in the status message   � ��� n ����� I  ������ *0 updatestatusmessage updateStatusMessage� ��� b  ����� m  ����  
Exporting    � n  ����� 1  ���
� 
pnam� o  ���� "0 currentdocument currentDocument�  �  �  f  ��� ��� l ����
�  �
  � ��� l ���	��	  � 0 *>Set the range of the pages to be exported   � ��� O  ����� r  ����� m  ���
� prngprna� 1  ���
� 
pcty� 1  ���
� 
DFpf� ��� l �����  �  � ��� l �����  � G A> Increase the progressbar by 1 because only on pages is exported   � ��� n ���� I  ����� *0 increaseprogressbar increaseProgressBar� �� � I � �� ��
�� .corecnte****       ****  n �� 2 ����
�� 
page o  ������ "0 currentdocument currentDocument��  �   �  �  f  ���  l ������  ��    l ����   J D> If prefReplaceFiles is set to false we're allowd  to replace files    	 Z  X
��
 =  l �� n  I  ������ 0 
fileexists 
fileExists  o  ���� 0 
savefolder 
saveFolder  o  ���� 0 filename fileName  c   n   1  	��
�� 
pnam o  	���� "0 currentdocument currentDocument m  ��
�� 
TEXT �� o  ���� $0 prefreplacefiles prefReplaceFiles��  ��    f  ��   m  ��
�� boovfals k  H   l ��!��  ! n h> Because the default timeout of Applescript is set to timeout after one minute we need to increase this     "��" t  H#$# k  #G%% &'& l ##��(��  (  > Export the page as pdf   ' )��) O  #G*+* I 'F����,
�� .K2  exptnull���     docu��  , ��-.
�� 
exft- m  +.��
�� eXftt_PD. ��/0
�� 
kfil/ l 181��1 b  18232 b  14454 o  12���� 0 
savefolder 
saveFolder5 o  23���� 0 filename fileName3 m  4766 
 .pdf   ��  0 ��78
�� 
usng7 o  ;<���� "0 pdfexportpreset PDFExportPreset8 ��9��
�� 
imot9 m  ?@��
�� boovfals��  + o  #$���� "0 currentdocument currentDocument��  $ l ":��: ]  ";<; o  ���� &0 prefscripttimeout prefScriptTimeout< m  !���� <��  ��  ��   k  KX== >?> l KK��@��  @  > Close the document   ? ABA O KUCDC I OT������
�� .CoReclosnull���     obj ��  ��  D o  KL���� "0 currentdocument currentDocumentB E��E L  VXFF m  VW��
�� boovfals��  	 G��G l YY������  ��  ��  
X HIH l [[������  ��  I JKJ l [[��L��  L  > Close the document   K M��M O [eNON I _d������
�� .CoReclosnull���     obj ��  ��  O o  [\���� "0 currentdocument currentDocument��  
 m     |
	 PQP l gg������  ��  Q RSR l gg��T��  T S M>Return a boolean to determin if the creation of the pdf was a success or not   S U��U L  giVV m  gh��
�� boovtrue��  	� WXW l     ������  ��  X YZY l     ��[��  [ 6 0#### Remove all items in the Tabview list ####--   Z \]\ l     ��^��  ^ ( "> The function takes no parameters   ] _`_ i     #aba I      �������� 0 	removeall 	removeAll��  ��  b k     =cc ded l     ��f��  f  > Set datasource   e ghg r     iji n     klk m   
 ��
�� 
datSl n     
mnm 4    
��o
�� 
tabWo m    	pp  fileList   n n     qrq 4    ��s
�� 
scrVs m    tt  files   r 4     ��u
�� 
cwinu m    vv 
 main   j o      ����  0 filelistsource fileListSourceh wxw r    yzy n    {|{ 1    ��
�� 
seDS| n    }~} 4    ��
�� 
tabW m    ��  fileList   ~ n    ��� 4    ���
�� 
scrV� m    ��  files   � 4    ���
�� 
cwin� m    �� 
 main   z o      ���� $0 selecteddatarows selectedDataRowsx ��� l   �����  � + %> Get the number of items in the list   � ��� r    %��� n    #��� m   ! #��
�� 
nmbr� n    !��� 2   !��
�� 
datR� o    ����  0 filelistsource fileListSource� o      ���� 0 
numoffiles 
numOfFiles� ��� l  & &�����  � L F> Loop the through the number of items in the list and remove each one   � ���� Y   & =�������� k   0 8�� ��� l  0 0�����  � $ >Delete the item from the list   � ���� I  0 8�����
�� .coredelonull���    obj � l  0 4���� n   0 4��� 4   1 4���
�� 
datR� m   2 3���� � o   0 1����  0 filelistsource fileListSource��  ��  ��  �� 0 n  � m   ) *���� � o   * +���� 0 
numoffiles 
numOfFiles��  ��  ` ��� l     ������  ��  � ��� l     �����  � : 4#### Remove selected item in the Tabview list ####--   � ��� l     �����  � ( "> The function takes no parameters   � ��� i   $ '��� I      ��������  0 removeselected removeSelected��  ��  � k     <�� ��� l     �����  �  >Set datasource   � ��� r     ��� n     ��� m   
 ��
�� 
datS� n     
��� 4    
���
�� 
tabW� m    	��  fileList   � n     ��� 4    ���
�� 
scrV� m    ��  files   � 4     ���
�� 
cwin� m    �� 
 main   � o      ����  0 filelistsource fileListSource� ��� r    ��� n    ��� 1    ��
�� 
seDS� n    ��� 4    ���
�� 
tabW� m    ��  fileList   � n    ��� 4    ���
�� 
scrV� m    ��  files   � 4    ���
�� 
cwin� m    �� 
 main   � o      ���� $0 selecteddatarows selectedDataRows� ��� l   �����  � ? 9> Check it any items are selected, if not nothing happens   � ���� Z    <������� ?    %��� l   #���� I   #�����
�� .corecnte****       ****� o    ���� $0 selecteddatarows selectedDataRows��  ��  � m   # $����  � O   ( 8��� k   / 7�� ��� l  / /�����  � % > Remove the item from the list   � ��� I  / 7�~��}
�~ .coredelonull���    obj � l  / 3��|� n   / 3��� 4   0 3�{�
�{ 
cobj� m   1 2�z�z � o   / 0�y�y $0 selecteddatarows selectedDataRows�|  �}  �  � 4   ( ,�x�
�x 
cwin� m   * +�� 
 main   ��  ��  ��  � ��� l     �w�v�w  �v  � ��� l     �u��u  � 0 *#### Count all pages inn a document ####--   � ��� l     �t��t  � Q K> The var open_document must be a complete path to the document to be opend   � ��� l     �s��s  � U O> The returned value is a number containing the number of pages in the document   � ��� i   ( +��� I      �r��q�r 0 
countpages 
countPages� ��p� o      �o�o 0 open_document  �p  �q  � k     &�� ��� O     #� � k    "  l   �n�n    > Open the document     r     I   �m	

�m .aevtodocnull  �    alis	 o    �l�l 0 open_document  
 �k�j
�k 
psiw m    �i
�i boovfals�j   o      �h�h 0 count_document    l   �g�g   ) #> Count number of pages in document     r     I   �f�e
�f .corecnte****       **** n    2   �d
�d 
page o    �c�c 0 count_document  �e   o      �b�b "0 pagesindocument pagesInDocument  l   �a�a    > Close the document    �` O   " I   !�_�^�]
�_ .CoReclosnull���     obj �^  �]   o    �\�\ 0 count_document  �`    m     |�  l  $ $�[�[   ! > Retun the munber of pages    �Z L   $ &   o   $ %�Y�Y "0 pagesindocument pagesInDocument�Z  � !"! l     �X�W�X  �W  " #$# l     �V%�V  % * $#### Check if the file exists ####--   $ &'& l     �U(�U  ( - '> This checks if a file allready exists   ' )*) l     �T+�T  + ] W> cfolder (string) must set and is the path to the folder we what to check for the file   * ,-, l     �S.�S  . � �> cfile (string) is the filename of the file we whant to check if exists. the must be passed as only the filename without the filename extension   - /0/ l     �R1�R  1 � �> cinddfile (string) is the name of the indesign document where the error occurs. this is only used to make sense of the indesign log.   0 232 l     �Q4�Q  4 R L> writeError (boolean) is used to determin wheter to write a errorlog or not   3 565 i   , /787 I      �P9�O�P 0 
fileexists 
fileExists9 :;: o      �N�N 0 cfolder  ; <=< o      �M�M 	0 cfile  = >?> o      �L�L 0 	cinddfile  ? @�K@ o      �J�J 0 
writeerror 
writeError�K  �O  8 O     �ABA k    �CC DED l    �IF�I  F � �
			This bit of code was removed because it caused a error when trying to 
			work with files on a remote volume. 
			
			-->set cfolder to cfolder as alias
		   E GHG l   �H�G�H  �G  H IJI l   �FK�F  K U O>Get a list of all the files in the folder where the file is trying to be saved   J LML r    NON c    PQP n    	RSR 1    	�E
�E 
pnamS n    TUT 2    �D
�D 
fileU o    �C�C 0 cfolder  Q m   	 
�B
�B 
listO o      �A�A 0 	cfilelist  M VWV l   �@X�@  X + %>Check if our filename is in the list   W Y�?Y Z    �Z[�>\Z E   ]^] o    �=�= 0 	cfilelist  ^ l   _�<_ b    `a` o    �;�; 	0 cfile  a m    bb 
 .pdf   �<  [ k    �cc ded l   �:f�:  f R L> If a file with the name exists, check if we whant to write a error message   e ghg Z    �ij�9�8i o    �7�7 0 
writeerror 
writeErrorj k    �kk lml l   �6n�6  n * $> Set the path for the errorlog-file   m opo r    #qrq c    !sts l   u�5u b    vwv b    xyx o    �4�4 0 cfolder  y o    �3�3 	0 cfile  w m    zz  _log.txt   �5  t m     �2
�2 
TEXTr o      �1�1 0 logsavepath logSavePathp {|{ l  $ $�0}�0  } 5 />This creates a file if the file does not exist   | ~~ I  $ +�/��
�/ .rdwropenshor       file� o   $ %�.�. 0 logsavepath logSavePath� �-��,
�- 
perm� m   & '�+
�+ boovtrue�,   ��� l  , ,�*��*  � % > Write the opening of the file   � ��� I  , >�)��
�) .rdwrwritnull���     ****� b   , 3��� m   , -��  	xPDF log:   � l  - 2��(� I  - 2�'��&
�' .sysontocTEXT       shor� m   - .�%�% 
�&  �(  � �$��
�$ 
refn� 4   4 8�#�
�# 
file� o   6 7�"�" 0 logsavepath logSavePath� �!�� 
�! 
wrat� m   9 :�
� rdwreof �   � ��� I  ? _���
� .rdwrwritnull���     ****� b   ? T��� b   ? N��� b   ? J��� b   ? H��� b   ? D��� m   ? B�� &  While trying to create the file    � o   B C�� 	0 cfile  � m   D G�� &  .pdf from the InDesign document    � o   H I�� 0 	cinddfile  � m   J M�� $  the following error occurred:   � l  N S��� I  N S���
� .sysontocTEXT       shor� m   N O�� 
�  �  � ���
� 
refn� 4   U Y��
� 
file� o   W X�� 0 logsavepath logSavePath� ���
� 
wrat� m   Z [�
� rdwreof �  � ��� I  ` ~���
� .rdwrwritnull���     ****� b   ` s��� b   ` o��� b   ` i��� b   ` e��� m   ` c��  A file with the name    � o   c d�� 	0 cfile  � m   e h��  .pdf allready exists.   � l  i n��� I  i n���
� .sysontocTEXT       shor� m   i j�� 
�  �  � m   o r��  No PDF-file was produced.   � ���
� 
refn� 4   t x�
�
�
 
file� o   v w�	�	 0 logsavepath logSavePath� ���
� 
wrat� m   y z�
� rdwreof �  � ��� l   ���  �  > Close the file   � ��� I   ����
� .rdwrclosnull���     ****� 4    ���
� 
file� o   � ��� 0 logsavepath logSavePath�  � ��� l  � �� ��   � 8 2>Return true since we now know that the file exist   � ���� L   � ��� m   � ���
�� boovtrue��  �9  �8  h ��� l  � ������  � V P>Although the file exists, writeError is set to false so the will be overwritten   � ���� L   � ��� m   � ���
�� boovfals��  �>  \ k   � ��� ��� l  � ������  � B <>Return false since we now know that the file does not exist   � ���� L   � ��� m   � ���
�� boovfals��  �?  B m     J6 ��� l     ������  ��  � ��� l     �����  � + %#### Check for document errors ####--   � ��� l     �����  � 0 *> This checks for missing images and fonts   � ��� l     �����  � 8 2> checkDocument must be a indesign document object   � ��� l     �����  � A ;> saveFolder is a string to the folder the file is saved to   � ��� l     �����  � ' !> missingImagesCheck is a boolean   � ��� l     �����  � &  > missingFontsCheck is a boolean   � ��� i   0 3��� I      ������� 0 
checkerror 
checkError� ��� o      ���� 0 checkdocument checkDocument� ��� o      ���� 0 
savefolder 
saveFolder� ��� o      ���� (0 missingimagescheck missingImagesCheck� ���� o      ���� &0 missingfontscheck missingFontsCheck��  ��  � k    y�� ��� l     �����  �  > Open Indesign   � ���� O    y��� k   x�� ��� l   �� ��     > Open the document   �  O   d k   c  l   ����   N H> missingImagesCheck is true then make a list of all the missing images     	
	 Z    `�� o    	���� (0 missingimagescheck missingImagesCheck Q    Y k    M  l   ����   7 1> Get a list of all missing or out of date images     r    . 6   , 6   # n     1    ��
�� 
pnam 2    ��
�� 
clnk =   "  1    ��
�� 
stts  b    !!"! m    ��
�� sttelmis" n     #$# 1     ��
�� 
pnam$ 2    ��
�� 
clnk =  $ +%&% 1   % '��
�� 
stts& m   ( *��
�� sttelood o      ���� 0 missingimages missingImages '(' l  / /��)��  ) T N> Because of a bug in InDesign we need to check if the reurned value is a list   ( *+* l  / /��,��  , W Q> It is not a list if only one image is missing, so then we need to set it again.   + -��- Z   / M./����. >  / 4010 n   / 2232 1   0 2��
�� 
pcls3 o   / 0���� 0 missingimages missingImages1 m   2 3��
�� 
list/ r   7 I454 J   7 G66 7��7 6  7 E898 n   7 <:;: 1   : <��
�� 
pnam; 2   7 :��
�� 
clnk9 =  = D<=< 1   > @��
�� 
stts= m   A C��
�� sttelmis��  5 o      ���� 0 missingimages missingImages��  ��  ��   R      ������
�� .ascrerr ****      � ****��  ��   k   U Y>> ?@? l  U U��A��  A H B> If there are noe images missing we still whant our var to be set   @ BCB l  U U��D��  D C => because we need it further down, so we create a empty list.   C E��E r   U YFGF J   U W����  G o      ���� 0 missingimages missingImages��  ��   k   \ `HH IJI l  \ \��K��  K L F> If missingImagesCheck is set to false we need to create a empty list   J LML l  \ \��N��  N D >> because we use the number of items in this list further down   M O��O r   \ `PQP J   \ ^����  Q o      ���� 0 missingimages missingImages��  
 RSR l  a a������  ��  S TUT Z   a �VW��XV o   a b���� &0 missingfontscheck missingFontsCheckW Q   e �YZ[Y k   h �\\ ]^] l  h h��_��  _ ' !> Get a list of all missing fonts   ^ `a` r   h xbcb 6  h vded n   h mfgf 1   k m��
�� 
pnamg 2   h k��
�� 
FonTe >  n uhih 1   o q��
�� 
sttsi m   r t��
�� fSTAfsInc o      ���� 0 missingfonts missingFontsa jkj l  y y��l��  l T N> Because of a bug in InDesign we need to check if the reurned value is a list   k mnm l  y y��o��  o V P> It is not a list if only one font is missing, so then we need to set it again.   n p��p Z   y �qr����q >  y ~sts n   y |uvu 1   z |��
�� 
pclsv o   y z���� 0 missingfonts missingFontst m   | }��
�� 
listr r   � �wxw J   � �yy z��z 6  � �{|{ n   � �}~} 1   � ���
�� 
pnam~ 2   � ���
�� 
FonT| >  � �� 1   � ���
�� 
stts� m   � ���
�� fSTAfsIn��  x o      ���� 0 missingfonts missingFonts��  ��  ��  Z R      ������
�� .ascrerr ****      � ****��  ��  [ k   � ��� ��� l  � ������  � H B> If there are noe images missing we still whant our var to be set   � ��� l  � ������  � C => because we need it further down, so we create a empty list.   � ���� r   � ���� J   � �����  � o      ���� 0 missingfonts missingFonts��  ��  X k   � ��� ��� l  � ������  � H B> If there are noe images missing we still whant our var to be set   � ��� l  � ������  � C => because we need it further down, so we create a empty list.   � ���� r   � ���� J   � �����  � o      ���� 0 missingfonts missingFonts��  U ��� l  � �������  ��  � ��� l  � ������  � * $> Set the path for the errorlog-file   � ��� r   � ���� c   � ���� l  � ����� b   � ���� b   � ���� b   � ���� o   � ����� 0 
savefolder 
saveFolder� m   � ���  :   � n   � ���� 1   � ���
�� 
pnam� o   � ����� 0 checkdocument checkDocument� m   � ���  _log.txt   ��  � m   � ���
�� 
TEXT� o      ���� 0 savepath savePath� ��� l  � �������  ��  � ��� l  � ������  � " > Set number of total errors   � ��� l  � ������  � H B> We need this var to deside if we whant to make a PDF-file or not   � ��� r   � ���� b   � ���� o   � ����� 0 missingimages missingImages� o   � ����� 0 missingfonts missingFonts� o      ���� 0 totalerrors totalErrors� ��� l  � �������  ��  � ��� l  � ������  � - '> If any errors occur create a logfile    � ��� Z   �+������� ?   � ���� l  � ����� I  � ������
�� .corecnte****       ****� o   � ����� 0 totalerrors totalErrors��  ��  � m   � ���  � k   �'�� ��� l  � ��~��~  � 5 />This creates a file if the file does not exist   � ��� I  � ��}��
�} .rdwropenshor       file� o   � ��|�| 0 savepath savePath� �{��z
�{ 
perm� m   � ��y
�y boovtrue�z  � ��� l  � ��x��x  � % > Write the opening of the file   � ��� I  � ��w��
�w .rdwrwritnull���     ****� b   � ���� m   � ���  	xPDF log:   � l  � ���v� I  � ��u��t
�u .sysontocTEXT       shor� m   � ��s�s 
�t  �v  � �r��
�r 
refn� 4   � ��q�
�q 
file� o   � ��p�p 0 savepath savePath� �o��n
�o 
wrat� m   � ��m
�m rdwreof �n  � ��� I  ��l��
�l .rdwrwritnull���     ****� b   ���� b   ���� b   � ���� m   � ��� * $You have missing images or fonts in    � n   � ���� 1   � ��k
�k 
pnam� o   � ��j�j 0 checkdocument checkDocument� l  ���i� I  ��h��g
�h .sysontocTEXT       shor� m   � ��f�f 
�g  �i  � m  ��  No PDF-file was produced.   � �e��
�e 
refn� 4  
�d�
�d 
file� o  �c�c 0 savepath savePath� �b��a
�b 
wrat� m  �`
�` rdwreof �a  � ��� l �_��_  �  > Close the file   � ��^� I '�]��\
�] .rdwrclosnull���     ****� 4  #�[�
�[ 
file� o  !"�Z�Z 0 savepath savePath�\  �^  ��  ��  � ��� l ,,�Y�X�Y  �X  � ��� l ,,�W��W  �  > Check for images   � ��� Z  ,� �V�U  ?  ,3 l ,1�T I ,1�S�R
�S .corecnte****       **** o  ,-�Q�Q 0 missingimages missingImages�R  �T   m  12�P�P   k  6�  l 66�O	�O  	  > Open the logfile    

 I 6?�N
�N .rdwropenshor       file o  67�M�M 0 savepath savePath �L�K
�L 
perm m  :;�J
�J boovtrue�K    I @h�I
�I .rdwrwritnull���     **** b  @S b  @K l @G�H I @G�G�F
�G .sysontocTEXT       shor m  @C�E�E 
�F  �H   m  GJ  Missing images:    l KR�D I KR�C�B
�C .sysontocTEXT       shor m  KN�A�A 
�B  �D   �@
�@ 
refn 4  V\�?
�? 
file o  Z[�>�> 0 savepath savePath �=�<
�= 
wrat m  _b�;
�; rdwreof �<    !  l ii�:"�:  " # >Write all the missing images   ! #$# Y  i�%�9&'�8% k  w�(( )*) r  w+,+ n  w}-.- 4  x}�7/
�7 
cobj/ o  {|�6�6 0 n  . o  wx�5�5 0 missingimages missingImages, o      �4�4  0 w_missingimage w_missingImage* 010 I ���323
�3 .rdwrwritnull���     ****2 o  ���2�2  0 w_missingimage w_missingImage3 �145
�1 
refn4 4  ���06
�0 
file6 o  ���/�/ 0 savepath savePath5 �.7�-
�. 
wrat7 m  ���,
�, rdwreof �-  1 8�+8 I ���*9:
�* .rdwrwritnull���     ****9 l ��;�); I ���(<�'
�( .sysontocTEXT       shor< m  ���&�& 
�'  �)  : �%=>
�% 
refn= 4  ���$?
�$ 
file? o  ���#�# 0 savepath savePath> �"@�!
�" 
wrat@ m  ��� 
�  rdwreof �!  �+  �9 0 n  & m  lm�� ' l mrA�A I mr�B�
� .corecnte****       ****B o  mn�� 0 missingimages missingImages�  �  �8  $ CDC l ���E�  E  > Close the file   D F�F I ���G�
� .rdwrclosnull���     ****G 4  ���H
� 
fileH o  ���� 0 savepath savePath�  �  �V  �U  � IJI l �����  �  J KLK l ���M�  M  > Check for fonts   L N�N Z  �cOP��O ?  ��QRQ l ��S�S I ���T�
� .corecnte****       ****T o  ���� 0 missingfonts missingFonts�  �  R m  ���
�
  P k  �_UU VWV l ���	X�	  X  > Open the logfile   W YZY I ���[\
� .rdwropenshor       file[ o  ���� 0 savepath savePath\ �]�
� 
perm] m  ���
� boovtrue�  Z ^_^ I ��`a
� .rdwrwritnull���     ****` b  ��bcb b  ��ded l ��f�f I ���g� 
� .sysontocTEXT       shorg m  ������ 
�   �  e m  ��hh  Missing fonts:   c l ��i��i I ����j��
�� .sysontocTEXT       shorj m  ������ 
��  ��  a ��kl
�� 
refnk 4  ����m
�� 
filem o  ������ 0 savepath savePathl ��n��
�� 
wratn m  ����
�� rdwreof ��  _ opo l ��q��  q " >Write all the missing fonts   p rsr Y  Tt��uv��t k  Oww xyx r  z{z n  |}| 4  ��~
�� 
cobj~ o  ���� 0 n  } o  ���� 0 missingfonts missingFonts{ o      ����  0 w_missingfonts w_missingFontsy � I 2����
�� .rdwrwritnull���     ****� o  ����  0 w_missingfonts w_missingFonts� ����
�� 
refn� 4   &���
�� 
file� o  $%���� 0 savepath savePath� �����
�� 
wrat� m  ),��
�� rdwreof ��  � ���� I 3O����
�� .rdwrwritnull���     ****� l 3:���� I 3:�����
�� .sysontocTEXT       shor� m  36���� 
��  ��  � ����
�� 
refn� 4  =C���
�� 
file� o  AB���� 0 savepath savePath� �����
�� 
wrat� m  FI��
�� rdwreof ��  ��  �� 0 n  u m  	���� v l 	���� I 	�����
�� .corecnte****       ****� o  	
���� 0 missingfonts missingFonts��  ��  ��  s ��� l UU�����  �  > Close the file   � ���� I U_�����
�� .rdwrclosnull���     ****� 4  U[���
�� 
file� o  YZ���� 0 savepath savePath��  ��  �  �  �   o    ���� 0 checkdocument checkDocument ��� l ee������  ��  � ��� l ee�����  � ; 5> Based on the result here we generate the PDF or not   � ��� Z  ev������ ?  el��� l ej���� I ej�����
�� .corecnte****       ****� o  ef���� 0 totalerrors totalErrors��  ��  � m  jk����  � L  oq�� m  op��
�� boovtrue��  � L  tv�� m  tu��
�� boovfals� ���� l ww������  ��  ��  � m     |��  � ��� l     ������  ��  � ��� l     �����  � J D#### Take a given path an return it as a colon separeted path ####--   � ��� l     �����  � 0 *> changePath the string path to be changed   � ��� i   4 7��� I      ������� 0 makecolonpath makeColonpath� ���� o      ���� 0 
changepath 
changePath��  ��  � k      �� ��� r     ��� m     ��  /   � n     ��� 1    ��
�� 
txdl� 1    ��
�� 
ascr� ��� r    ��� n    	��� 2    	��
�� 
citm� o    ���� 0 
changepath 
changePath� o      ���� 0 tmppath tmpPath� ��� r    ��� l   ���� m    ��  :   ��  � n     ��� 1    ��
�� 
txdl� 1    ��
�� 
ascr� ��� r    ��� c    ��� o    ���� 0 tmppath tmpPath� m    ��
�� 
TEXT� l     ���� o      ���� 0 tmppath tmpPath��  � ��� r    ��� l   ���� m    ��      ��  � n     ��� 1    ��
�� 
txdl� 1    ��
�� 
ascr� ���� L     �� o    ���� 0 tmppath tmpPath��  � ��� l     ������  ��  � ��� l     �����  � = 7#### Initiate the progressbar of the statuspanel ####--   � ��� l     �����  � I C> maxValue is a number that is the max value for the progrescounter   � ��� i   8 ;��� I      ������� $0 initiateporgress initiatePorgress� ���� o      ���� 0 maxvalue maxValue��  ��  � O     "��� k   
 !�� ��� r   
 ��� m   
 ��
�� boovfals� 1    ��
�� 
indR� ��� r    ��� m    ����  � 1    ��
�� 
minW� ��� r    ��� o    ���� 0 maxvalue maxValue� 1    ��
�� 
maxV� ���� r    !��� m    ����  � 1     ��
�� 
pcnt��  � n     ��� 4    �� 
�� 
proI  m      progress   � 4     ��
�� 
cwin m      progressPanel   �  l     ������  ��    l     ����   * $#### Increase the progressbar ####--    	
	 l     ����   L F> incremental is a number containing the number of values to increment   
  i   < ? I      ������ *0 increaseprogressbar increaseProgressBar �� o      ���� 0 incremental  ��  ��   k       l     ����    > increas the progress    �� O     I  
 ����
�� .coVSincEnull���    obj ��   ����
�� 
by B o    ���� 0 incremental  ��   n      4    ��
�� 
proI m      progress    4     ��
�� 
cwin m        progressPanel   ��   !"! l     ������  ��  " #$# l     ��%��  % + %#### Update the status message ####--   $ &'& l     �(�  ( 6 0> new_message is a string containing the message   ' )*) i   @ C+,+ I      �~-�}�~ *0 updatestatusmessage updateStatusMessage- .�|. o      �{�{ 0 new_message  �|  �}  , k     // 010 l     �z2�z  2   > update the statusmessage   1 3�y3 r     454 c     676 o     �x�x 0 new_message  7 m    �w
�w 
TEXT5 n      898 1   
 �v
�v 
pcnt9 n    
:;: 4    
�u<
�u 
texF< m    	==  statusMessage   ; 4    �t>
�t 
cwin> m    ??  progressPanel   �y  * @A@ l     �s�r�s  �r  A BCB l     �qD�q  D 5 /#### Update the text in the summaryfield ####--   C EFE l     �pG�p  G ; 5> preset is a string containing the preset to retrive   F HIH l     �oJ�o  J  > returns true   I KLK i   D GMNM I      �nO�m�n  0 updatedsummary updatedSummaryO P�lP o      �k�k 
0 preset  �l  �m  N k    7QQ RSR l     �jT�j  T B <> Get the full path to the jobotions document for the preset   S UVU O     WXW r    YZY c    [\[ n    
]^] 1    
�i
�i 
fnam^ 4    �h_
�h 
PFst_ o    �g�g 
0 preset  \ m   
 �f
�f 
TEXTZ o      �e�e  0 joboptionspath joboptionsPathX m     |V `a` l   �d�c�d  �c  a bcb l   �bd�b  d # > Open the jobotions document   c efe r    ghg I   �ai�`
�a .rdwropenshor       filei o    �_�_  0 joboptionspath joboptionsPath�`  h o      �^�^ 0 openjoboption openJoboptionf jkj l   �]�\�]  �\  k lml l   �[n�[  n # > Read the file into a string   m opo r    qrq I   �Zs�Y
�Z .rdwrread****        ****s o    �X�X 0 openjoboption openJoboption�Y  r o      �W�W 0 joboptiondata joboptionDatap tut l     �V�U�V  �U  u vwv l     �Tx�T  x $ > Close the access to the file   w yzy I    %�S{�R
�S .rdwrclosnull���     ****{ o     !�Q�Q 0 openjoboption openJoboption�R  z |}| l  & &�P�O�P  �O  } ~~ l  & &�N��N  � ; 5> Create a list of the the data in the jobotions file    ��� l  & &�M��M  � 5 /> Ever line in the document is made into a item   � ��� r   & /��� l  & +��L� I  & +�K��J
�K .sysontocTEXT       shor� m   & '�I�I 
�J  �L  � n     ��� 1   , .�H
�H 
txdl� 1   + ,�G
�G 
ascr� ��� r   0 7��� c   0 5��� n   0 3��� 2   1 3�F
�F 
citm� o   0 1�E�E 0 joboptiondata joboptionData� m   3 4�D
�D 
list� o      �C�C 0 joboptionlist joboptionList� ��� r   8 =��� l  8 9��B� m   8 9��      �B  � n     ��� 1   : <�A
�A 
txdl� 1   9 :�@
�@ 
ascr� ��� l  > >�?�>�?  �>  � ��� l  > >�=��=  � - '> Loop thrugh all the lines in the file   � ��� Y   >4��<���;� k   K/�� ��� l  K K�:��:  � S M> A error is retuned if a line has less the character that we are looking for   � ��� l  K K�9��9  � O I> to prevet this error for occuring we check the length of the line first   � ��8� Z   K/���7�6� ?  K [��� l  K W��5� n   K W��� m   S W�4
�4 
nmbr� n  K S��� 2  O S�3
�3 
cha � n   K O��� 4   L O�2�
�2 
cobj� o   M N�1�1 0 p  � o   K L�0�0 0 joboptionlist joboptionList�5  � m   W Z�/�/ � k   ^+�� ��� l  ^ ^�.��.  � / )> Set the first 8 characters in the line    � ��� r   ^ t��� c   ^ r��� l  ^ p��-� n   ^ p��� 7  b p�,��
�, 
cha � m   h j�+�+ � m   k o�*�* � l  ^ b��)� n   ^ b��� 4   _ b�(�
�( 
cobj� o   ` a�'�' 0 p  � o   ^ _�&�& 0 joboptionlist joboptionList�)  �-  � m   p q�%
�% 
TEXT� o      �$�$ 0 getline getLine� ��� l  u u�#��#  � F @> If the chatacters in getLine is the ones we are searching for    � ��"� Z   u+���!� � =  u z��� o   u v�� 0 getline getLine� m   v y��      /ENU   � k   }'�� ��� l  } }���  � 2 ,> Extract only the part of the line we whant   � ��� r   } ���� c   } ���� l  } ���� n   } ���� 7  � ����
� 
cha � m   � ��� � l  � ���� \   � ���� l  � ���� n   � ���� m   � ��
� 
nmbr� n  � ���� 2  � ��
� 
cha � n   � ���� 4   � ���
� 
cobj� o   � ��� 0 p  � o   � ��� 0 joboptionlist joboptionList�  � m   � ��� �  � l  } ���� c   } ���� n   } ���� 4   ~ ���
� 
cobj� o    ��� 0 p  � o   } ~�� 0 joboptionlist joboptionList� m   � ��
� 
TEXT�  �  � m   � ��
� 
TEXT� o      �� &0 presetdescription presetDescription� ��� l   � ����  � � � 
				There might be some bug here, because some times the above statment dosent remove the ending ")" from the text 
				To fix this we need to check if the last character is a ")"  and then remove it
				   � ��� Z   ����
�� ?  � ���� l  � � �	  n   � � m   � ��
� 
nmbr n  � � 2  � ��
� 
cha  o   � ��� &0 presetdescription presetDescription�	  � m   � ��� � k   �   r   � �	 c   � �

 l  � �� n   � � 7  � ��
� 
cha  l  � �� \   � � l  � �� c   � � n   � � m   � �� 
�  
nmbr n  � � 2  � ���
�� 
cha  o   � ����� &0 presetdescription presetDescription m   � ���
�� 
nmbr�   m   � ����� �   l  � ��� n   � � m   � ���
�� 
nmbr n  � � 2  � ���
�� 
cha  o   � ����� &0 presetdescription presetDescription��   o   � ����� &0 presetdescription presetDescription�   m   � ���
�� 
TEXT	 o      ���� 0 lastchar lastChar  !  l  � �������  ��  ! "��" Z   � #$����# =  � �%&% o   � ����� 0 lastchar lastChar& m   � �''  .)   $ r   � �()( c   � �*+* l  � �,��, n   � �-.- 7  � ���/0
�� 
cha / m   � ����� 0 l  � �1��1 \   � �232 l  � �4��4 n   � �565 m   � ���
�� 
nmbr6 n  � �787 2  � ���
�� 
cha 8 o   � ����� &0 presetdescription presetDescription��  3 m   � ����� ��  . o   � ����� &0 presetdescription presetDescription��  + m   � ���
�� 
TEXT) o      ���� &0 presetdescription presetDescription��  ��  ��  �
  � r  9:9 m  ;;  No description.   : o      ���� &0 presetdescription presetDescription� <=< l 		������  ��  = >?> l 		��@��  @ : 4> Set the contents of the summary to the description   ? ABA r  	%CDC o  	
���� &0 presetdescription presetDescriptionD n      EFE 1   $��
�� 
pcntF n  
 GHG 4   ��I
�� 
texVI m  JJ  summary   H n  
KLK 4  ��M
�� 
scrVM m  NN  summaryContainer   L 4  
��O
�� 
cwinO m  PP 
 main   B Q��Q  S  &'��  �!  �   �"  �7  �6  �8  �< 0 p  � m   A B���� � l  B FR��R n   B FSTS 1   C E��
�� 
lengT o   B C���� 0 joboptionlist joboptionList��  �;  � UVU l 55������  ��  V W��W L  57XX m  56��
�� boovtrue��  L YZY l     ������  ��  Z [\[ l     ������  ��  \ ]^] l     ��_��  _ G A#### This handler is called when the prefs window is opend ####--   ^ `a` i   H Kbcb I     ��d��
�� .appSwilOnull���    obj d o      ���� 0 	theobject 	theObject��  c Z     Jef����e =    ghg l    i��i c     jkj n     lml 1    ��
�� 
pnamm o     ���� 0 	theobject 	theObjectk m    ��
�� 
TEXT��  h m    nn  preferences   f k   
 Foo pqp l  
 
��r��  r ' !> Set the state of the prefrences   q sts r   
 uvu n   
 wxw 1    ��
�� 
pcntx n   
 yzy 4    ��{
�� 
defE{ m    ||  prefLeadingZero   z 1   
 ��
�� 
useDv n      }~} 1    ��
�� 
pcnt~ n    � 4    ���
�� 
butT� m    ��  cb_LeadingZero   � 4    ���
�� 
cwin� m    ��  preferences   t ��� r    /��� n    %��� 1   # %��
�� 
pcnt� n    #��� 4     #���
�� 
defE� m   ! "��  prefReplaceFiles   � 1     ��
�� 
useD� n      ��� 1   , .��
�� 
pcnt� n   % ,��� 4   ) ,���
�� 
butT� m   * +��  cb_ReplaceFiles   � 4   % )���
�� 
cwin� m   ' (��  preferences   � ���� r   0 F��� n   0 8��� 1   6 8��
�� 
pcnt� n   0 6��� 4   3 6���
�� 
defE� m   4 5��  prefScriptTimeout   � 1   0 3��
�� 
useD� n      ��� 1   C E��
�� 
pcnt� n   8 C��� 4   < C���
�� 
texF� m   ? B��  tf_scriptTimeout   � 4   8 <���
�� 
cwin� m   : ;��  preferences   ��  ��  ��  a ��� l     ������  ��  � ��� l     �����  � H B#### This handler is called when the prefs window is closed ####--   � ��� i   L O��� I     �����
�� .appSwilCnull���    obj � o      ���� 0 	theobject 	theObject��  � Z     �������� =    ��� l    ���� c     ��� n     ��� 1    ��
�� 
pnam� o     ���� 0 	theobject 	theObject� m    ��
�� 
TEXT��  � m    ��  preferences   � k   
 ��� ��� l  
 
�����  � a [> Update the values in the plistfile based on the current stat of the UI in the pref window   � ��� r   
 ��� c   
 ��� n   
 ��� 1    ��
�� 
pcnt� n   
 ��� 4    ���
�� 
butT� m    ��  cb_LeadingZero   � 4   
 ���
�� 
cwin� m    ��  preferences   � m    ��
�� 
bool� n      ��� 1    ��
�� 
pcnt� n    ��� 4    ���
�� 
defE� m    ��  prefLeadingZero   � 1    ��
�� 
useD� ��� r    3��� c    *��� n    (��� 1   & (��
�� 
pcnt� n    &��� 4   # &���
�� 
butT� m   $ %��  cb_ReplaceFiles   � 4    #���
�� 
cwin� m   ! "��  preferences   � m   ( )��
�� 
bool� n      ��� 1   0 2��
�� 
pcnt� n   * 0��� 4   - 0���
�� 
defE� m   . /��  prefReplaceFiles   � 1   * -��
�� 
useD� ��� r   4 P��� c   4 E��� n   4 A��� 1   ? A��
�� 
pcnt� n   4 ?��� 4   8 ?���
�� 
texF� m   ; >��  tf_scriptTimeout   � 4   4 8���
�� 
cwin� m   6 7��  preferences   � m   A D��
�� 
nmbr� n      ��� 1   M O��
�� 
pcnt� n   E M��� 4   H M���
�� 
defE� m   I L��  prefScriptTimeout   � 1   E H��
�� 
useD� ��� l  Q Q������  ��  � ��� l  Q Q�� ��    T N>If the prefs are changed during a session we need to update out global values   �  r   Q d c   Q ` n   Q ^ 1   \ ^��
�� 
pcnt n   Q \	
	 4   W \��
�� 
butT m   X [  cb_LeadingZero   
 4   Q W��
�� 
cwin m   S V  preferences    m   ^ _��
�� 
bool o      ���� "0 prefleadingzero prefLeadingZero  r   e x c   e t n   e r 1   p r��
�� 
pcnt n   e p 4   k p��
�� 
butT m   l o  cb_ReplaceFiles    4   e k��
�� 
cwin m   g j  preferences    m   r s��
�� 
bool o      ���� $0 prefreplacefiles prefReplaceFiles � r   y � c   y � !  n   y �"#" 1   � ��~
�~ 
pcnt# n   y �$%$ 4    ��}&
�} 
texF& m   � �''  tf_scriptTimeout   % 4   y �|(
�| 
cwin( m   { ~))  preferences   ! m   � ��{
�{ 
nmbr o      �z�z &0 prefscripttimeout prefScriptTimeout�  ��  ��  � *+* l     �y�x�y  �x  + ,�w, j   P V�v-�v 60 asdscriptuniqueidentifier ASDScriptUniqueIdentifier- m   P S..  xPDF.applescript   �w       �u/0123456789:;<=>?@ABC.�u  / �t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e�d�c�b�a�`
�t .appSwiFLnull���    obj 
�s .appSawFNnull���    obj 
�r .appSlauNnull���    obj 
�q .appSclTInull���    obj 
�p .appSupTInull���    obj 
�o .coVScliInull���    obj 
�n .menSchMInull���    obj �m 0 	createpdf 	createPDF�l 0 	removeall 	removeAll�k  0 removeselected removeSelected�j 0 
countpages 
countPages�i 0 
fileexists 
fileExists�h 0 
checkerror 
checkError�g 0 makecolonpath makeColonpath�f $0 initiateporgress initiatePorgress�e *0 increaseprogressbar increaseProgressBar�d *0 updatestatusmessage updateStatusMessage�c  0 updatedsummary updatedSummary
�b .appSwilOnull���    obj 
�a .appSwilCnull���    obj �` 60 asdscriptuniqueidentifier ASDScriptUniqueIdentifier0 �_ Z�^�]DE�\
�_ .appSwiFLnull���    obj �^ 0 	theobject 	theObject�]  D �[�[ 0 	theobject 	theObjectE  �Z e�Y h�X r�W p�V ~ |�U�T�S�R�Q�P�O ��N�M�L�K � � � ��J ��I ��H
�Z 
cwin
�Y 
attT
�X .panSdisQnull���    obj 
�W 
proI
�V .coVSstaAnull���    obj 
�U 
indR
�T 
kocl
�S 
defE
�R 
insh
�Q 
useD
�P 
prdt
�O 
pnam
�N 
pcnt�M �L 
�K .corecrel****      � null�J "0 prefleadingzero prefLeadingZero�I $0 prefreplacefiles prefReplaceFiles�H &0 prefscripttimeout prefScriptTimeout�\ �*��/�*��/l O*��/��/ *j UO*��/��/ e*�,FUO*���*�,�,6a a a a ea a  O*���*�,�,6a a a a ea a  O*���*�,�,6a a a a a a a  O*�,�a /a ,E` O*�,�a /a ,E` O*�,�a /a ,E` 1 �G ��F�EFG�D
�G .appSawFNnull���    obj �F 0 	theobject 	theObject�E  F �C�B�C 0 	theobject 	theObject�B "0 documenttoolbar documentToolbarG `�A�@�?�>�= ��< ��;�:�9�8�7�6�5�4�3!$&�2�10369<>�0�/UX�.[�-^�,a�+csvy|��������������������*��)��(�'�&�%�$	�#'%!�"�!J� ����
�A 
kocl
�@ 
tbar
�? 
insh
�> 
prdt
�= 
pnam
�< 
ideT
�; 
allC
�: 
auSC
�9 
disM
�8 disMdeDM
�7 
sizM
�6 sizMdeSM�5 �4 
�3 .corecrel****      � null�2 	
�1 
allI
�0 
defI
�/ 
tooI
�. 
labB
�- 
palL
�, 
tooT
�+ 
imaN
�* 
cwin
�) 
draA
�( 
on O
�' EReTrigE
�& .caVSopeDnull���    obj 
�% 
boxO
�$ 
texF
�# 
ediT
�" 
matT
�! 
enaB
�  
sdsk
� 
TEXT� 0 	startdisk 	startDisk
� 
cha 
� 
nmbr�D*���*6������e�f������ E�Oa a a a a a a a a a v�a ,FOa a a a a  a !�v�a ",FO*�a #�a #-6��a $�a %a &a 'a (a )a *a +a ,a -�� O*�a #�a #-6��a .�a /a &a 0a (a 1a *a 2a ,a 3�� O*�a #�a #-6��a 4�a 5a &a 6a (a 7a *a 8a ,a 9�� O*�a #�a #-6��a :�a ;a &a <a (a =a *a >a ,a ?�� O*�a #�a #-6��a @�a Aa &a Ba (a Ca *a Da ,a E�� O���,FO*a Fa G/ *a Ha I/ *a Ja Kl LUUOf*a Fa M/a Ha N/a Oa P/a Qa R/a S,FOf*a Fa T/a Ha U/a Oa V/a Wa X/a Y,FOa Z 3*a [,a \&E` ]O_ ][a ^\[Zk\Z_ ]a ^-a _,k2a \&E` ]U2 �P��HI�
� .appSlauNnull���    obj � 0 	theobject 	theObject�  H ����� 0 	theobject 	theObject� 0 pdfpresetlist PDFpresetList� 0 numofpreset numOfPreset� 0 i  I +|����������
��	��������������� �������������������������
� 
PFst
� 
pnam
� 
list
� 
cobj
� 
nmbr�  �  
� 
as A
� EAlTwarN
�
 
mesS�	 

� .sysontocTEXT       shor
� 
defB
� 
attT
� 
cwin� 
� .panSdisAnull���    obj 
� 
popB
� 
menE
�  
menI
�� .coredelonull���    obj 
�� 
kocl
�� 
insh
�� 
prdt
�� 
titl
�� 
enaB�� �� 
�� .corecrel****      � null��  0 updatedsummary updatedSummary
�� .panScloPnull���    obj � � � *�-�,�&E�O��-�,E�UW 5X  ������j %�%�j %a %a a a *a a /a  O*a a /a a /a ,a -j O Hk�kh *a a a *a a  /a a !/a ,a -6a "a #��/a $ea %a & '[OY��O)��k/k+ (O*a a )/j *OP3 �������JK��
�� .appSclTInull���    obj �� 0 	theobject 	theObject��  J ������������������������������������������������������ 0 	theobject 	theObject�� $0 filelistchecknum fileListChecknum�� &0 savelocationcheck saveLocationCheck�� 0 basenamecheck baseNameCheck�� 0 basenametext baseNameText�� &0 extractpagescheck extractPagesCheck�� $0 extractpagestype extractPagesType�� (0 missingimagescheck missingImagesCheck�� &0 missingfontscheck missingFontsCheck�� "0 pdfexportpreset PDFExportPreset�� 0 
saveresult 
saveResult�� 0 
savefolder 
saveFolder��  0 filelistsource fileListSource�� 0 thepaths thePaths�� 0 thefiles theFiles�� 0 
numoffiles 
numOfFiles�� 0 
totalpages 
totalPages�� 0 count_i  �� 0 open_document  �� 0 i  �� 0 opendocument openDocument�� 0 length_filename  �� (0 currentdrawerstate currentDrawerState�� 0 errorresult errorResult�� 0 error_i  �� "0 currentdocument currentDocumentK ���
����+��)��%������7������<��?��B����e��c��_��[����~|xt������������������������������
����*2��������������������������������������������������������������#)5��@RP������hf������yw������������������751|������������
�� 
ideT��  0 runincremental runIncremental
�� 
cwin
�� 
scrV
�� 
tabW
�� 
datS
�� 
datR
�� 
nmbr
�� 
as A
�� EAlTwarN
�� 
mesS
�� 
defB
�� 
attT�� 
�� .panSdisAnull���    obj 
�� 
draA
�� 
boxO
�� 
butT
�� 
pcnt
�� 
bool
�� 
texF
�� 
TEXT
�� 
matT
�� 
curR
�� 
popB
�� 
titl
�� 
opeP
�� 
proO
�� 
tPAD
�� 
caCD
�� 
caCF
�� 
alMT
�� .panSdisPnull���    obj 
�� 
filO
�� 
list
�� 
ascr
�� 
txdl�� 0 	startdisk 	startDisk
�� .panSdisQnull���    obj 
�� 
proI
�� 
indR
�� 
datC
�� 
cobj�� 0 makecolonpath makeColonpath�� 0 
countpages 
countPages�� $0 initiateporgress initiatePorgress
�� 
cha �� 
�� 0 	createpdf 	createPDF
�� .appSloaInull���    obj 
�� .panScloPnull���    obj 
�� 
staB
�� EDrEdrCS
�� EDrEdrCT
�� .caVSopeDnull���    obj 
�� EDrEdrOT
�� EDrEdrOS
�� .caVScloDnull���    obj ��  0 removeselected removeSelected�� 0 	removeall 	removeAll
�� 
psiw
�� .aevtodocnull  �    alis�� �� 0 
checkerror 
checkError
�� .CoReclosnull���     obj ��W��,� �jE�O*��/��/��/�,�-�,E�O�j  $����a a a a *�a /a  OfY hO*�a /a a /a a /a a /a ,a &E�O*�a  /a a !/a a "/a a #/a ,a &E�O*�a $/a a %/a a &/a 'a (/a ,a )&E�O*�a */a a +/a a ,/a a -/a ,a &E�O*�a ./a a //a a 0/a 1a 2/a 3,�&E�O*�a 4/a a 5/a a 6/a a 7/a ,a &E�O*�a 8/a a 9/a a :/a a ;/a ,a &E�O*�a </a =a >/a ?,a )&E�O� M*a @, 5a A*a ?,FOa B*a C,FOf*a D,FOe*a E,FOf*a F,FOf*a G,FUO*a @,j HE�Y kE�O�k 2� <*a @,a I,a J&E�Oa K_ La M,FO_ N�%a O%a )&E�Oa P_ La M,FY a QE�O*�a R/a *�a S/l TO*�a U/a Va W/ 	f*a X,FUO*�a Y/�a Z/�a [/�,E�O*�a \/�a ]/�a ^/�,�-a _a `/a ,E�O*�a a/�a b/�a c/�,�-a _a d/a ,E�O*�a e/�a f/�a g/�,�-�,E�OjE^ O Dk�kh _ N�a h] /%a )&E^ O)] k+ ia )&E^ O] )] k+ jE^ [OY��O)] k+ kO �k�kh _ N�a h] /%a )&E^ O)] k+ ia )&E^ O� V�a h] /a l-�,�&E^ O_ N�a h] /[a l\[Zk\Z�a h] /a l-�,] 2%a )&E�O)�k+ ia )&E�Y )�k+ ia )&E�O)] ��������] a m+ ne  a oj p��] /a _a q/a ,FY a rj p��] /a _a s/a ,F[OY�O*�a t/j uY hOPY`��,a v  �*�a w/a a x/a y,E^ O] a z 
 ] a { a & *�a |/a a }/ *j ~UY 4] a  
 ] a � a & *�a �/a a �/ *j �UY hOPYؠ�,a �  )j+ �OPYĠ�,a �  )j+ �OPY���,a � �*�a �/a *�a �/l TO*�a �/a Va �/ 	f*a X,FUO*�a �/�a �/�a �/�,E�O*�a �/�a �/�a �/�,�-a _a �/a ,E�O*�a �/�a �/�a �/�,�-a _a �/a ,E�O*�a �/�a �/�a �/�,�-�,E�OeE^ O �k�kh _ N�a h] /%a )&E^ O)] k+ ia )&E^ O�a h] /a l-�,�&E^ O_ N�a h] /[a l\[Zk\Z�a h] /a l-�,] 2%a )&E�O)�k+ ia )&E�Oa � :] a �fl �E^ O)] �eea �+ �f  
fE^ Y hO]  *j �UUO] e  a �j p��] /a _a �/a ,FY hOP[OY�O*�a �/j uOPY h4 ������LM��
�� .appSupTInull���    obj �� 0 	theobject 	theObject��  L ���� 0 	theobject 	theObjectM  �� e5 ��(����NO��
�� .coVScliInull���    obj �� 0 	theobject 	theObject��  N ���������� 0 	theobject 	theObject�� $0 objectidentifier objectIdentifier�� 0 basenamecheck baseNameCheck�� &0 extractpagescheck extractPagesCheckO &����A��[��Y��U��Q����uso��k����}���������~��}����
�� 
pnam
�� 
TEXT
�� 
cwin
�� 
draA
�� 
boxO
�� 
butT
�� 
pcnt
�� 
bool
�� 
texF
� 
ediT
�~ 
matT
�} 
enaB�� ̠�,�&E�O��  V*��/��/��/��/�,�&E�O� e*��/��/��/a a /a ,FY f*�a /�a /�a /a a /a ,FOPY k�a   b*�a /�a /�a /�a /�,�&E�O� "e*�a /�a /�a /a a  /a !,FY f*�a "/�a #/�a $/a a %/a !,FY h6 �|��{�zPQ�y
�| .menSchMInull���    obj �{ 0 	theobject 	theObject�z  P �x�w�v�u�x 0 	theobject 	theObject�w  0 menuidentifier menuIdentifier�v 0 pdfpresetlist PDFpresetList�u $0 currentpdfpreset currentPDFpresetQ .�t�s	�r	
�q	�p	�o	)�n	A	K�m	S	\	t�l	s�k�j�i	|�h�g�f	��e�d	��c	��b	��a�`|�_�^�]�\�[�Z�Y�X
�t 
titl
�s 
TEXT
�r 
cwin
�q 
inFO
�p .appSshoHnull���    obj �o  0 removeselected removeSelected�n 0 	removeall 	removeAll
�m .appSloaNnull���    obj 
�l .miscactvnull��� ��� null
�k .GURLGURLnull��� ��� TEXT�j  �i  
�h 
as A
�g EAlTwarN
�f 
mesS�e 

�d .sysontocTEXT       shor
�c 
defB
�b 
attT�a 
�` .panSdisAnull���    obj 
�_ 
PFst
�^ 
pnam
�] 
list
�\ 
kocl
�[ 
cobj
�Z .corecnte****       ****
�Y 
ctxt�X  0 updatedsummary updatedSummary�y ���,�&E�O��  *��/�*��/l OPY ١�  )j+ 	OPY ɡ�  )j+ OPY ���  �j O*��/j OPY ��a   T a  *j Oa j UW 7X  a a a a a a j %a %a a  a !*�a "/a # $Y Fa % *a &-a ',a (&E�UO ,�[a )a *l +kh �a ,&�  )�k+ -Y h[OY��7 �W	��V�URS�T�W 0 	createpdf 	createPDF�V �ST�S 
T 
 �R�Q�P�O�N�M�L�K�J�I�R 0 opendocument openDocument�Q 0 
savefolder 
saveFolder�P "0 pdfexportpreset PDFExportPreset�O 0 basenamecheck baseNameCheck�N 0 basenametext baseNameText�M &0 extractpagescheck extractPagesCheck�L $0 extractpagestype extractPagesType�K (0 missingimagescheck missingImagesCheck�J &0 missingfontscheck missingFontsCheck�I 0 incremental  �U  R �H�G�F�E�D�C�B�A�@�?�>�=�<�;�:�H 0 opendocument openDocument�G 0 
savefolder 
saveFolder�F "0 pdfexportpreset PDFExportPreset�E 0 basenamecheck baseNameCheck�D 0 basenametext baseNameText�C &0 extractpagescheck extractPagesCheck�B $0 extractpagestype extractPagesType�A (0 missingimagescheck missingImagesCheck�@ &0 missingfontscheck missingFontsCheck�? 0 incremental  �> "0 currentdocument currentDocument�= 
0 page_i  �< 0 filename fileName�; 0 length_extension  �: 0 start_extesion  S *|�9�8
&�7�6�5�4�3�2�1�0�/�.�-�,
��+�*�)
� �(�'�&�%�$�#�"�!� �T�������6
�9 
psiw
�8 .aevtodocnull  �    alis
�7 
pnam�6 *0 updatestatusmessage updateStatusMessage
�5 
bool�4 �3 0 
checkerror 
checkError
�2 .CoReclosnull���     obj 
�1 
page
�0 .corecnte****       ****�/  0 runincremental runIncremental
�. 
nmbr�- "0 prefleadingzero prefLeadingZero�, 

�+ 
TEXT
�* 
cha �) 
�( 
DFpf
�' 
pcty�& *0 increaseprogressbar increaseProgressBar�% $0 prefreplacefiles prefReplaceFiles�$ 0 
fileexists 
fileExists�# &0 prefscripttimeout prefScriptTimeout�" <
�! 
exft
�  eXftt_PD
� 
kfil
� 
usng
� 
imot� 
� .K2  exptnull���     docu
� prngprna�Tj�c��fl E�O)��,%k+ O�
 �e �& $)�����+ e  � *j 	UOfY hY hO�/k��-j kh �k  ���&E�Y ��/�,�&E�O� �� a �%E�Y hY hO� ��%a &E�Y 7��,a &E�O�a -�,E�O�a a &E�O�[a \[Zk\Z�2�%a &E�O)a ��,%a %�%a %��-j %k+ O��/�,*a ,a ,FO)kk+ O)����,a &_ �+ f  2_ a  n� !*a a a  ��%a !%a "�a #fa $ %UoY � *j 	UOfOP[OY��O̪�-j E�OPY �� �� a &�%E�Y hY hO� ��%a &E�Y 5��,a &E�O�a -�,E�O�a a &E�O�[a \[Zk\Z�2a &E�O)a '��,%k+ O*a , a (*a ,FUO)��-j k+ O)����,a &_ �+ f  2_ a  n� !*a a a  ��%a )%a "�a #fa $ %UoY � *j 	UOfOPO� *j 	UUOe8 �b��UV�� 0 	removeall 	removeAll�  �  U �����  0 filelistsource fileListSource� $0 selecteddatarows selectedDataRows� 0 
numoffiles 
numOfFiles� 0 n  V �v�t�p��������

� 
cwin
� 
scrV
� 
tabW
� 
datS
� 
seDS
� 
datR
� 
nmbr
�
 .coredelonull���    obj � >*��/��/��/�,E�O*��/��/��/�,E�O��-�,E�O k�kh ��k/j [OY��9 �	���WX��	  0 removeselected removeSelected�  �  W ���  0 filelistsource fileListSource� $0 selecteddatarows selectedDataRowsX ������� ������������
� 
cwin
� 
scrV
� 
tabW
�  
datS
�� 
seDS
�� .corecnte****       ****
�� 
cobj
�� .coredelonull���    obj � =*��/��/��/�,E�O*��/��/��/�,E�O�j j *��/ 
��k/j UY h: �������YZ���� 0 
countpages 
countPages�� ��[�� [  ���� 0 open_document  ��  Y �������� 0 open_document  �� 0 count_document  �� "0 pagesindocument pagesInDocumentZ |����������
�� 
psiw
�� .aevtodocnull  �    alis
�� 
page
�� .corecnte****       ****
�� .CoReclosnull���     obj �� '�  ��fl E�O��-j E�O� *j UUO�; ��8����\]���� 0 
fileexists 
fileExists�� ��^�� ^  ���������� 0 cfolder  �� 	0 cfile  �� 0 	cinddfile  �� 0 
writeerror 
writeError��  \ �������������� 0 cfolder  �� 	0 cfile  �� 0 	cinddfile  �� 0 
writeerror 
writeError�� 0 	cfilelist  �� 0 logsavepath logSavePath] J������bz�����������������������������
�� 
file
�� 
pnam
�� 
list
�� 
TEXT
�� 
perm
�� .rdwropenshor       file�� 

�� .sysontocTEXT       shor
�� 
refn
�� 
wrat
�� rdwreof �� 
�� .rdwrwritnull���     ****
�� .rdwrclosnull���     ****�� �� ���-�,�&E�O���% �� u��%�%�&E�O��el O��j %�*�/��� Oa �%a %�%a %�j %�*�/��� Oa �%a %�j %a %�*�/��� O*�/j OeY hOfY fU< �������_`���� 0 
checkerror 
checkError�� ��a�� a  ���������� 0 checkdocument checkDocument�� 0 
savefolder 
saveFolder�� (0 missingimagescheck missingImagesCheck�� &0 missingfontscheck missingFontsCheck��  _ ������������������������ 0 checkdocument checkDocument�� 0 
savefolder 
saveFolder�� (0 missingimagescheck missingImagesCheck�� &0 missingfontscheck missingFontsCheck�� 0 missingimages missingImages�� 0 missingfonts missingFonts�� 0 savepath savePath�� 0 totalerrors totalErrors�� 0 n  ��  0 w_missingimage w_missingImage��  0 w_missingfonts w_missingFonts` "|����b���������������������������������������������������h
�� 
clnk
�� 
pnamb  
�� 
stts
�� sttelmis
�� sttelood
�� 
pcls
�� 
list��  ��  
�� 
FonT
�� fSTAfsIn
�� 
TEXT
�� .corecnte****       ****
�� 
perm
�� .rdwropenshor       file�� 

�� .sysontocTEXT       shor
�� 
refn
�� 
file
�� 
wrat
�� rdwreof �� 
�� .rdwrwritnull���     ****
�� .rdwrclosnull���     ****
�� 
cobj��z�v�]� R C*�-�,�[�,\Z�*�-�,%81�[�,\Z�81E�O��,� *�-�,�[�,\Z�81kvE�Y hW X 	 
jvE�Y jvE�O� C 4*�-�,�[�,\Z�91E�O��,� *�-�,�[�,\Z�91kvE�Y hW X 	 
jvE�Y jvE�O��%��,%�%�&E�O��%E�O�j j c�a el Oa a j %a *a �/a a a  Oa ��,%a j %a %a *a �/a a a  O*a �/j Y hO�j j ��a el Oa j a %a j %a *a �/a a a  O Nk�j kh �a  �/E�O�a *a �/a a a  Oa j a *a �/a a a  [OY��O*a �/j Y hO�j j ��a el Oa j a !%a j %a *a �/a a a  O Nk�j kh �a  �/E�O�a *a �/a a a  Oa j a *a �/a a a  [OY��O*a �/j Y hUO�j j eY fOPU= �������cd���� 0 makecolonpath makeColonpath�� ��e�� e  ���� 0 
changepath 
changePath��  c ������ 0 
changepath 
changePath�� 0 tmppath tmpPathd �����������
�� 
ascr
�� 
txdl
�� 
citm
�� 
TEXT�� !���,FO��-E�O���,FO��&E�O���,FO�> �������fg���� $0 initiateporgress initiatePorgress�� ��h�� h  ���� 0 maxvalue maxValue��  f ���� 0 maxvalue maxValueg �������
�� 
cwin
� 
proI
� 
indR
� 
minW
� 
maxV
� 
pcnt�� #*��/��/ f*�,FOj*�,FO�*�,FOj*�,FU? ���ij�� *0 increaseprogressbar increaseProgressBar� �k� k  �� 0 incremental  �  i �� 0 incremental  j � ���
� 
cwin
� 
proI
� 
by B
� .coVSincEnull���    obj � *��/��/ 	*�l U@ �,�~�}lm�|� *0 updatestatusmessage updateStatusMessage�~ �{n�{ n  �z�z 0 new_message  �}  l �y�y 0 new_message  m �x�w?�v=�u
�x 
TEXT
�w 
cwin
�v 
texF
�u 
pcnt�| ��&*��/��/�,FA �tN�s�rop�q�t  0 updatedsummary updatedSummary�s �pq�p q  �o�o 
0 preset  �r  o 	�n�m�l�k�j�i�h�g�f�n 
0 preset  �m  0 joboptionspath joboptionsPath�l 0 openjoboption openJoboption�k 0 joboptiondata joboptionData�j 0 joboptionlist joboptionList�i 0 p  �h 0 getline getLine�g &0 presetdescription presetDescription�f 0 lastchar lastCharp |�e�d�c�b�a�`�_�^�]�\�[�Z��Y�X�W�V�U��T';�SP�RN�QJ�P
�e 
PFst
�d 
fnam
�c 
TEXT
�b .rdwropenshor       file
�a .rdwrread****        ****
�` .rdwrclosnull���     ****�_ 

�^ .sysontocTEXT       shor
�] 
ascr
�\ 
txdl
�[ 
citm
�Z 
list
�Y 
leng
�X 
cobj
�W 
cha 
�V 
nmbr�U �T 
�S 
cwin
�R 
scrV
�Q 
texV
�P 
pcnt�q8� *�/�,�&E�UO�j E�O�j E�O�j O�j ��,FO��-�&E�O���,FO �k��,Ekh ��/a -a ,a  Ҥ�/[a \[Zk\Za 2�&E�O�a   ���/�&[a \[Za \Z��/a -a ,k2�&E�O�a -a ,l T�[a \[Z�a -a ,a &k\Z�a -a ,2�&E�O�a    �[a \[Zk\Z�a -a ,k2�&E�Y hY a E�O�*a a /a a /a a /a ,FOY hY h[OY�OeB �Oc�N�Mrs�L
�O .appSwilOnull���    obj �N 0 	theobject 	theObject�M  r �K�K 0 	theobject 	theObjects �J�In�H�G|�F�E��D�������C�
�J 
pnam
�I 
TEXT
�H 
useD
�G 
defE
�F 
pcnt
�E 
cwin
�D 
butT
�C 
texF�L K��,�&�  A*�,��/�,*��/��/�,FO*�,��/�,*��/��/�,FO*�,��/�,*��/a a /�,FY hC �B��A�@tu�?
�B .appSwilCnull���    obj �A 0 	theobject 	theObject�@  t �>�> 0 	theobject 	theObjectu �=�<��;��:��9�8�7�6������5��4��3�2)'�1
�= 
pnam
�< 
TEXT
�; 
cwin
�: 
butT
�9 
pcnt
�8 
bool
�7 
useD
�6 
defE
�5 
texF
�4 
nmbr�3 "0 prefleadingzero prefLeadingZero�2 $0 prefreplacefiles prefReplaceFiles�1 &0 prefscripttimeout prefScriptTimeout�? ���,�&�  �*��/��/�,�&*�,��/�,FO*��/��/�,�&*�,��/�,FO*��/a a /�,a &*�,�a /�,FO*�a /�a /�,�&E` O*�a /�a /�,�&E` O*�a /a a /�,a &E` Y hascr  ��ޭ