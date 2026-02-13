{{- define "online-boutique.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "online-boutique.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "online-boutique.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "online-boutique.labels" -}}
helm.sh/chart: {{ include "online-boutique.chart" . }}
{{ include "online-boutique.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "online-boutique.selectorLabels" -}}
app.kubernetes.io/name: {{ include "online-boutique.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "online-boutique.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "online-boutique.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "online-boutique.image" -}}
{{- $registry := .Values.global.registry -}}
{{- $prefix := .Values.global.imagePrefix -}}
{{- $tag := .Values.global.imageTag -}}
{{- $service := .service -}}
{{- printf "%s/%s/%s:%s" $registry $prefix $service $tag -}}
{{- end }}
