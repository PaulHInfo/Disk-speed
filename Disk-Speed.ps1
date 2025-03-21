########################################################################
# Project's code name : D.S.C.                                         #
# Editor :  	[REDACTED]                                  		   # 		   #
# Date : 	    [REDACTED]											   #
# Version :     1.16                                                   #  
#             					          							   #
#                                                    				   #
#		                                                               #
#                                                                      #
#		                                             				   #
#		                                                               #
#     			  													   #
#																	   #
########################################################################
#Generated Form Function
function GenerateForm {
    ########################################################################
    # Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.16.0
    # Generated On: 2019
    # Generated By: [REDACTED]
    ########################################################################

    #region Import the Assemblies
    [reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
    [reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
    #endregion
    #declaration of some variables with default value.
    [int] $nbOfFile = 100
    [int64] $fileSize = 1000 #doc 
    [double]$time = 0
    [boolean] $validateur = $false
    [double] $timeSecond = 00
    #region Generated Form Objects
    $form1 = New-Object System.Windows.Forms.Form
    $label12 = New-Object System.Windows.Forms.Label
    $label11 = New-Object System.Windows.Forms.Label
    $label10 = New-Object System.Windows.Forms.Label
    $progressBar1 = New-Object System.Windows.Forms.ProgressBar
    $label9 = New-Object System.Windows.Forms.Label
    $label8 = New-Object System.Windows.Forms.Label
    $label7 = New-Object System.Windows.Forms.Label
    $label6 = New-Object System.Windows.Forms.Label
    $label5 = New-Object System.Windows.Forms.Label
    $label4 = New-Object System.Windows.Forms.Label
    $button1 = New-Object System.Windows.Forms.Button
    $richTextBox1 = New-Object System.Windows.Forms.RichTextBox
    $trackBar2 = New-Object System.Windows.Forms.TrackBar
    $trackBar1 = New-Object System.Windows.Forms.TrackBar
    $label3 = New-Object System.Windows.Forms.Label
    $label2 = New-Object System.Windows.Forms.Label
    $label1 = New-Object System.Windows.Forms.Label
    $comboBox1 = New-Object System.Windows.Forms.ComboBox
    $InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
    #endregion Generated Form Objects

    #----------------------------------------------
    #Generated Event Script Blocks
    #----------------------------------------------
    #Provide Custom Code for events specified in PrimalForms.
    $button1_OnClick = 
    {   #creat directory's name
        $datecurrent = Get-Date -Format ss.ffff
        [string]$directoryName = "TS_D.S.C.$datecurrent"
        #get values
        $valueTb1 = $trackBar1.Value
        $valueTb2 = $trackBar2.Value
        #add value for creating files
        if ($valueTb1 -eq 1) {
            $nbOfFile = 100
        }
        elseif ($valueTb1 -eq 2) {
            $nbOfFile = 1000
        }
        elseif ($valueTb1 -eq 3) {
            $nbOfFile = 10000
        }
        else {
            #this last condition is just if we a have a bug with the value of track bar
            $richTextBox1.AppendText("Sorry we have a problem, try to turn off and turn on again")
        }
        #add value for the file size
        if ($valueTb2 -eq 1) {
            $fileSize = 1000
        }
        elseif ($valueTb2 -eq 2) {
            $fileSize = 10000
        }
        elseif ($valueTb2 -eq 3) {
            $fileSize = 100000 
        }
        else {
            #this last condition is just if we a have a bug with th value of track bar
            $richTextBox1.AppendText("Sorry we have a problem, try to turn off and turn on again")
        }
        #if the directory already exists, we ask to the user if he want to delete it
        $diskComboBox = $comboBox1.SelectedItem
        if (Test-Path "$diskComboBox\$directoryName") {
            $richTextBox1.AppendText("/!\ $directoryName is already in $diskComboBox /!\`n")
            #create the dialogue box 
            Add-Type -AssemblyName PresentationCore, PresentationFramework
            $ButtonType = [System.Windows.MessageBoxButton]::YesNo
            $MessageIcon = [System.Windows.MessageBoxImage]::Exclamation
            $MessageBody = "$directoryName already exist, can we delete it? `n if you select no, we will rename our directory,"
            $MessageTitle = "Rename your directory"
            $Result = [System.Windows.MessageBox]::Show($MessageBody, $MessageTitle, $ButtonType, $MessageIcon)
            #we test the result
            if ($Result -eq "Yes") {
                #here, we delete the directory and we create a new one
                Remove-Item "$diskComboBox\$directoryName" -Force -Recurse
            }
            elseif ($Result -eq "No") {
                #if the result is no we will rename our directory
                $diskComboBox = $diskComboBox + "ïhggrfhngfhnjimzutzrbgfvedkp098ujzhxcWWW"
            }
        }
        else {
            New-Item -Path "$diskComboBox\" -Name $directoryName -ItemType "directory" -Force
        }
        #here, we creat all files and we record the time in millisecond
        try {
            $i = 0 
            $progressBar1.Minimum = 0
            $progressBar1.Maximum = $nbOfFile
            #here, we record the time.
            [double]$timeStartSecond = Get-Date -Format ss.fff
            do {
                #here, we are creating all files
                $file1 = new-object System.IO.FileStream "$diskComboBox\$directoryName\pi$i.txt", Create, ReadWrite 
                $file1.setlength($fileSize)
                $file1.Close()
                $validateur = $True
                $i++
                $progressBar1.Value = $i
            } until ($i -eq $nbOfFile)
            [double]$timeEndSecond = Get-Date -Format ss.fff
            [double]$timeSecond = $timeEndSecond - $timeStartSecond
            $time = [math]::Round($timeSecond, 3)
            if ($validateur -eq $true) {
                $richTextBox1.AppendText("$nbOfFile files have been created on disk $diskComboBox in $time Second-s `n")
            }
        }
        catch {
            #if the logical disk has disappeared (like a USB key)
            $richTextBox1.AppendText("the disk $diskComboBox has disappeared or you can't writ on `n")
        }
        #delete the
        Remove-Item "$diskComboBox\$directoryName" -Force -Recurse
    }
    $OnLoadForm_StateCorrection =
    { #Correct the initial state of the form to prevent the .Net maximized form issue
        $form1.WindowState = $InitialFormWindowState
    }
    #----------------------------------------------
    #put the letters of all disks in the combobx, but we delete the letter of the DVD driver
	
    $listDisk = (Get-CimInstance Win32_LogicalDisk).DeviceID 
    $lecteur = (Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -eq 5 }).DeviceID
    for ($i = 0; $i -lt $listDisk.length; $i++) {
        $comboBox1.Items.Add($listDisk[$i])
        if ($comboBox1.Items[$i] -eq $lecteur) {
            $comboBox1.Items.Remove($lecteur)
        }
    }
    $comboBox1.SelectedIndex = 0
    #----------------------------------------------
    #region Generated Form Code
    $form1.BackColor = [System.Drawing.Color]::FromArgb(255, 185, 209, 234)
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 637
    $System_Drawing_Size.Width = 570
    $form1.ClientSize = $System_Drawing_Size
    $form1.DataBindings.DefaultDataSourceUpdateMode = 0
    $form1.Name = "form1"
    $form1.Text = "Primal Form"

    $label12.DataBindings.DefaultDataSourceUpdateMode = 0
    $label12.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, 0, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 13
    $System_Drawing_Point.Y = 47
    $label12.Location = $System_Drawing_Point
    $label12.Name = "label12"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 23
    $System_Drawing_Size.Width = 544
    $label12.Size = $System_Drawing_Size
    $label12.TabIndex = 15
    $label12.Text = "This script calculates the speed of your disk"
    $label12.TextAlign = 32
    $label12.add_Click($handler_label12_Click)

    $form1.Controls.Add($label12)

    $label11.DataBindings.DefaultDataSourceUpdateMode = 0

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 13
    $System_Drawing_Point.Y = 269
    $label11.Location = $System_Drawing_Point
    $label11.Name = "label11"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 15
    $System_Drawing_Size.Width = 100
    $label11.Size = $System_Drawing_Size
    $label11.TabIndex = 14
    $label11.Text = "file size"
    $label11.add_Click($handler_label11_Click)

    $form1.Controls.Add($label11)

    $label10.DataBindings.DefaultDataSourceUpdateMode = 0

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 13
    $System_Drawing_Point.Y = 171
    $label10.Location = $System_Drawing_Point
    $label10.Name = "label10"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 15
    $System_Drawing_Size.Width = 100
    $label10.Size = $System_Drawing_Size
    $label10.TabIndex = 13
    $label10.Text = "Number of files"
    $label10.add_Click($handler_label10_Click)

    $form1.Controls.Add($label10)

    $progressBar1.DataBindings.DefaultDataSourceUpdateMode = 0
    $progressBar1.ForeColor = [System.Drawing.Color]::FromArgb(255, 0, 192, 0)
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 11
    $System_Drawing_Point.Y = 398
    $progressBar1.Location = $System_Drawing_Point
    $progressBar1.Name = "progressBar1"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 23
    $System_Drawing_Size.Width = 545
    $progressBar1.Size = $System_Drawing_Size
    $progressBar1.TabIndex = 12

    $form1.Controls.Add($progressBar1)

    $label9.DataBindings.DefaultDataSourceUpdateMode = 0
    $label9.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 512
    $System_Drawing_Point.Y = 323
    $label9.Location = $System_Drawing_Point
    $label9.Name = "label9"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 23
    $System_Drawing_Size.Width = 46
    $label9.Size = $System_Drawing_Size
    $label9.TabIndex = 11
    $label9.Text = "100K"

    $form1.Controls.Add($label9)

    $label8.DataBindings.DefaultDataSourceUpdateMode = 0
    $label8.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 263
    $System_Drawing_Point.Y = 323
    $label8.Location = $System_Drawing_Point
    $label8.Name = "label8"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 23
    $System_Drawing_Size.Width = 37
    $label8.Size = $System_Drawing_Size
    $label8.TabIndex = 10
    $label8.Text = "10K"

    $form1.Controls.Add($label8)

    $label7.DataBindings.DefaultDataSourceUpdateMode = 0
    $label7.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 11
    $System_Drawing_Point.Y = 323
    $label7.Location = $System_Drawing_Point
    $label7.Name = "label7"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 20
    $System_Drawing_Size.Width = 40
    $label7.Size = $System_Drawing_Size
    $label7.TabIndex = 9
    $label7.Text = "1K"

    $form1.Controls.Add($label7)

    $label6.DataBindings.DefaultDataSourceUpdateMode = 0
    $label6.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 512
    $System_Drawing_Point.Y = 237
    $label6.Location = $System_Drawing_Point
    $label6.Name = "label6"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 14
    $System_Drawing_Size.Width = 55
    $label6.Size = $System_Drawing_Size
    $label6.TabIndex = 8
    $label6.Text = "10'000"

    $form1.Controls.Add($label6)

    $label5.DataBindings.DefaultDataSourceUpdateMode = 0
    $label5.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 263
    $System_Drawing_Point.Y = 237
    $label5.Location = $System_Drawing_Point
    $label5.Name = "label5"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 18
    $System_Drawing_Size.Width = 47
    $label5.Size = $System_Drawing_Size
    $label5.TabIndex = 7
    $label5.Text = "1000"
    $label5.add_Click($handler_label5_Click)

    $form1.Controls.Add($label5)

    $label4.DataBindings.DefaultDataSourceUpdateMode = 0
    $label4.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 11
    $System_Drawing_Point.Y = 237
    $label4.Location = $System_Drawing_Point
    $label4.Name = "label4"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 18
    $System_Drawing_Size.Width = 41
    $label4.Size = $System_Drawing_Size
    $label4.TabIndex = 6
    $label4.Text = "100"

    $form1.Controls.Add($label4)


    $button1.DataBindings.DefaultDataSourceUpdateMode = 0
    $button1.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 8.25, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 12
    $System_Drawing_Point.Y = 349
    $button1.Location = $System_Drawing_Point
    $button1.Name = "button1"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 36
    $System_Drawing_Size.Width = 546
    $button1.Size = $System_Drawing_Size
    $button1.TabIndex = 5
    $button1.Text = "R U N  !"
    $button1.UseVisualStyleBackColor = $True
    $button1.add_Click($button1_OnClick)

    $form1.Controls.Add($button1)

    $richTextBox1.DataBindings.DefaultDataSourceUpdateMode = 0
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 11
    $System_Drawing_Point.Y = 427
    $richTextBox1.Location = $System_Drawing_Point
    $richTextBox1.Name = "richTextBox1"
    $richTextBox1.ReadOnly = $True
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 198
    $System_Drawing_Size.Width = 546
    $richTextBox1.Size = $System_Drawing_Size
    $richTextBox1.TabIndex = 4
    $richTextBox1.Text = ""

    $form1.Controls.Add($richTextBox1)

    $trackBar2.DataBindings.DefaultDataSourceUpdateMode = 0
    $trackBar2.LargeChange = 3
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 12
    $System_Drawing_Point.Y = 287
    $trackBar2.Location = $System_Drawing_Point
    $trackBar2.Maximum = 3
    $trackBar2.Minimum = 1
    $trackBar2.Name = "trackBar2"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 45
    $System_Drawing_Size.Width = 545
    $trackBar2.Size = $System_Drawing_Size
    $trackBar2.TabIndex = 3
    $trackBar2.Value = 1

    $form1.Controls.Add($trackBar2)

    $trackBar1.BackColor = [System.Drawing.Color]::FromArgb(255, 185, 209, 234)
    $trackBar1.DataBindings.DefaultDataSourceUpdateMode = 0
    $trackBar1.LargeChange = 3
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 12
    $System_Drawing_Point.Y = 200
    $trackBar1.Location = $System_Drawing_Point
    $trackBar1.Maximum = 3
    $trackBar1.Minimum = 1
    $trackBar1.Name = "trackBar1"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 45
    $System_Drawing_Size.Width = 546
    $trackBar1.Size = $System_Drawing_Size
    $trackBar1.TabIndex = 3
    $trackBar1.Value = 1

    $form1.Controls.Add($trackBar1)

    $label3.DataBindings.DefaultDataSourceUpdateMode = 0
    $label3.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 9, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 11
    $System_Drawing_Point.Y = 76
    $label3.Location = $System_Drawing_Point
    $label3.Name = "label3"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 23
    $System_Drawing_Size.Width = 546
    $label3.Size = $System_Drawing_Size
    $label3.TabIndex = 3
    $label3.Text = " Warning-Only use 10'000 files if you have a powerful disk"
    $label3.TextAlign = 32
    $label3.add_Click($handler_label3_Click)

    $form1.Controls.Add($label3)

    $label2.Anchor = 15
    $label2.DataBindings.DefaultDataSourceUpdateMode = 0
    $label2.Font = New-Object System.Drawing.Font("Arial", 24, 1, 3, 1)

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 13
    $System_Drawing_Point.Y = 9
    $label2.Location = $System_Drawing_Point
    $label2.Name = "label2"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 34
    $System_Drawing_Size.Width = 546
    $label2.Size = $System_Drawing_Size
    $label2.TabIndex = 2
    $label2.Text = "Disk speed calculator"
    $label2.TextAlign = 32
    $label2.add_Click($handler_label2_Click)

    $form1.Controls.Add($label2)

    $label1.DataBindings.DefaultDataSourceUpdateMode = 0

    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 426
    $System_Drawing_Point.Y = 105
    $label1.Location = $System_Drawing_Point
    $label1.Name = "label1"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 23
    $System_Drawing_Size.Width = 132
    $label1.Size = $System_Drawing_Size
    $label1.TabIndex = 1
    $label1.Text = "Select the disk's letter"
    $label1.add_Click($handler_label1_Click)

    $form1.Controls.Add($label1)

    $comboBox1.DataBindings.DefaultDataSourceUpdateMode = 0
    $comboBox1.DropDownStyle = 2
    $comboBox1.Enabled = $True
    $System_Drawing_Point = New-Object System.Drawing.Point
    $System_Drawing_Point.X = 13
    $System_Drawing_Point.Y = 102
    $comboBox1.Location = $System_Drawing_Point
    $comboBox1.Name = "comboBox1"
    $System_Drawing_Size = New-Object System.Drawing.Size
    $System_Drawing_Size.Height = 21
    $System_Drawing_Size.Width = 181
    $comboBox1.Size = $System_Drawing_Size
    $comboBox1.Sorted = $False
    $comboBox1.TabIndex = 0
    $comboBox1.TabStop = $False
    $comboBox1.add_SelectedIndexChanged($handler_comboBox1_SelectedIndexChanged)

    $form1.Controls.Add($comboBox1)

    #endregion Generated Form Code

    #Save the initial state of the form
    $InitialFormWindowState = $form1.WindowState
    #Init the OnLoad event to correct the initial state of the form
    $form1.add_Load($OnLoadForm_StateCorrection)
    #Show the Form
    $form1.ShowDialog() | Out-Null

} #End Function

#Call the Function
GenerateForm
