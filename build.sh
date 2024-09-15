py -3 -m venv .venv                    
.venv\Scripts\activate
pip install --upgrade pip
pip install -r requirements.txt
reflex init
reflex export --frontend-only
Remove-Item -Recurse -Force public
mkdir public
Expand-Archive -Path frontend.zip -DestinationPath public
Remove-Item -Force frontend.zip
deactivate

#Deploy
reflex deploy --no-interactive -k ceramica -r eze 
