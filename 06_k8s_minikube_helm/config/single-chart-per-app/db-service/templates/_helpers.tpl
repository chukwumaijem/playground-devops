{{- define "labels" -}}
  app: {{ .Values.app.name }}
{{- end }}

{{- define "envs" -}}
  {{- range .Values.image.environment }}
    - name: {{ .name }}
      value: {{ .value }}
  {{- end }}
{{- end }}
