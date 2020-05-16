#!/bin/bash

date2=$(date +"%d-%m-%Y")
DOW=$(date +"%A")

header(){
echo '<!DOCTYPE html>'
echo '<html>'
        echo '<head>'
                echo '<title>Server Stats Report</title>'
                echo '<link rel="icon" href="logo.png">'
                echo "<link href="bootstrap/css/bootstrap.css" rel="stylesheet">"
                echo '<style>'
                        echo '.row{'
                                echo 'margin:0px;'
                        echo '}'

                        echo '.center {'
                          echo 'display: block;'
                          echo 'margin-left: auto;'
                          echo 'margin-right: auto;'
                          echo 'width: 50%;'
                        echo '}'
                echo '</style>'
        echo '</head>'
}

footer(){
               echo '<div class="row" style="text-align:center;">'
                        echo "<a href="index.html">REFRESH</a><br /><br />"
                        echo '<p>opentechy.com</p>'
                echo '</div>'
                echo "<!--<script src="bootstrap/js/bootstrap.js"></script>-->"
        echo '</body>'
echo '</html>'
}

body(){
        echo '<body>'
                echo '<br />'
                echo '<div class="row">'
                        echo '<img src="logo.jpg" alt="Vodafone Logo" class="center" style="width:220px; height:180px;">'
                        echo '<h2 style="text-align:center;">SERVERS STATS REPORT</h2>'
			echo '<div class="row" style="text-align:center;">'
                        echo "<p>$date2</p>"
                	echo '</div>'

			
                echo '</div>'
                echo '<br />'
                echo '<div class="row">'
                        echo '<div class="col-md-6 col-md-offset-3">'
                                echo '<table class="table table-condensed" style="width:100%;">'
                                        echo '<tr style="background:#000; color:#fff;">'
                                               echo '<th>SERVER IP</th>'
                                                echo '<th>DISK USAGE (%)</th>'
                                                echo '<th>CPU USAGE (%)</th>'
                                                echo '<th>MEMORY USAGE (%)</th>'
                                       echo ' </tr>'
		for server in $(more /root/scripts/server-list.txt)
			do
		os_id=$(ssh -q $server rpm -qa \*-release | grep -Ei "oracle|redhat|centos" |cut -d"-" -f1)
		el_version=$(ssh -q $server rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3 | cut -c1)
			if [ "$el_version" == "6" ]; then			
		scpu=$(ssh -q $server iostat | grep -E '^ ' | awk '{printf("%.1f"), 100-$6}')
		smem=$(ssh -q $server free -g -t | head -n 3 | awk 'NR==3 {printf("%.1f"), $3/($4+$3)*100}')
		sdisk=$(ssh -q $server df -h --exclude=nfs4 --total | awk 'NR==1; END{print}' | awk 'NR==2' | awk '{print $5}' | sed 's/%//')					
					echo '<tr>'
                                                echo "<td>$server</td>"
                                                echo "<td>$sdisk</td>"
                                                echo "<td>$scpu</td>"
                                                echo "<td>$smem</td>"
                                        echo '</tr>'
			fi
			if [ "$el_version" == "7" ]; then
		scpu=$(ssh -q $server iostat | grep -E '^ ' | awk '{printf("%.1f"), 100-$6}')
                smem=$(ssh -q $server free -g -t | head -n 2 | awk 'NR==2 {printf("%.1f"), ($2-$4)/$2*100}')
                sdisk=$(ssh -q $server df -h --exclude=nfs4 --total | awk 'NR==1; END{print}' | awk 'NR==2' | awk '{print $5}' | sed 's/%//')
                                        echo '<tr>'
                                                echo "<td>$server</td>"
                                                echo "<td>$sdisk</td>"
                                                echo "<td>$scpu</td>"
                                                echo "<td>$smem</td>"
                                        echo '</tr>'
                        fi		
			done
                                echo '</table>'
                        echo '</div>'
                echo '</div>'
} 

#run functions
header
body
footer

