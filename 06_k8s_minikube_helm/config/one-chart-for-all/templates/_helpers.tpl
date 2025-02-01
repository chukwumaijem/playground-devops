{{- define "db-labels" -}}
  app: {{.Values.product.name }}-{{ .Values.apps.database.name }}
{{- end }}

{{- define "db-envs" -}}
  {{- range .Values.apps.database.image.environment }}
    - name: {{ .name }}
      value: {{ .value }}
  {{- end }}
{{- end }}


{{- define "redis-labels" -}}
  app: {{.Values.product.name }}-{{ .Values.apps.redis.name }}
{{- end }}


{{- define "result-ui-labels" -}}
  app: {{ .Values.apps.result_ui.name }}
{{- end }}

{{- define "worker-labels" -}}
  app: {{ .Values.apps.worker.name }}
{{- end }}


{{- define "vote-ui-labels" -}}
  app: {{ .Values.apps.vote_ui.name }}
{{- end }}
