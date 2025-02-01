{{- define "vote-app.name" -}}
{{.Values.app.name}}
{{- end }}


{{- define "labels" -}}
app: {{ .Values.app.name }}
{{- end }}
