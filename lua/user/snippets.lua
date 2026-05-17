-- Custom snippets using built-in vim.snippet (no LuaSnip needed)

local snippets = {
  go = {
    main    = "func main() {\n\t${0}\n}",
    func    = "func ${1:name}(${2:args}) ${3:error} {\n\t${0}\n}",
    meth    = "func (${1:r} ${2:Type}) ${3:name}(${4:args}) ${5:error} {\n\t${0}\n}",
    iferr   = "if err != nil {\n\treturn ${0:err}\n}",
    forr    = "for ${1:i}, ${2:v} := range ${3:slice} {\n\t${0}\n}",
    fori    = "for ${1:i} := 0; ${1:i} < ${2:n}; ${1:i}++ {\n\t${0}\n}",
    str     = "type ${1:Name} struct {\n\t${0}\n}",
    iface   = "type ${1:Name} interface {\n\t${0}\n}",
    test    = "func Test${1:Name}(t *testing.T) {\n\t${0}\n}",
    bench   = "func Benchmark${1:Name}(b *testing.B) {\n\tfor i := 0; i < b.N; i++ {\n\t\t${0}\n\t}\n}",
    gorout  = "go func() {\n\t${0}\n}()",
    init    = "func init() {\n\t${0}\n}",
    prtf    = 'fmt.Printf("${1:%v}\\n", ${0})',
    prtln   = 'fmt.Println(${0})',
  },
  lua = {
    func    = "function ${1:name}(${2:args})\n\t${0}\nend",
    lfunc   = "local function ${1:name}(${2:args})\n\t${0}\nend",
    loc     = "local ${1:name} = ${0}",
    iferr   = "if ${1:err} then\n\t${0}\nend",
    forr    = "for ${1:k}, ${2:v} in pairs(${3:t}) do\n\t${0}\nend",
    fori    = "for ${1:i} = 1, ${2:n} do\n\t${0}\nend",
  },
  yaml = {
    -- Workloads
    deploy  = "apiVersion: apps/v1\nkind: Deployment\nmetadata:\n  name: ${1:app}\n  labels:\n    app: ${1:app}\nspec:\n  replicas: ${2:1}\n  selector:\n    matchLabels:\n      app: ${1:app}\n  template:\n    metadata:\n      labels:\n        app: ${1:app}\n    spec:\n      containers:\n      - name: ${1:app}\n        image: ${3:nginx:latest}\n        ports:\n        - containerPort: ${4:80}\n${0}",
    sts     = "apiVersion: apps/v1\nkind: StatefulSet\nmetadata:\n  name: ${1:app}\nspec:\n  serviceName: ${1:app}\n  replicas: ${2:1}\n  selector:\n    matchLabels:\n      app: ${1:app}\n  template:\n    metadata:\n      labels:\n        app: ${1:app}\n    spec:\n      containers:\n      - name: ${1:app}\n        image: ${3:nginx:latest}\n        ports:\n        - containerPort: ${4:80}\n        volumeMounts:\n        - name: data\n          mountPath: ${5:/data}\n  volumeClaimTemplates:\n  - metadata:\n      name: data\n    spec:\n      accessModes: [ReadWriteOnce]\n      resources:\n        requests:\n          storage: ${6:1Gi}\n${0}",
    ds      = "apiVersion: apps/v1\nkind: DaemonSet\nmetadata:\n  name: ${1:app}\n  labels:\n    app: ${1:app}\nspec:\n  selector:\n    matchLabels:\n      app: ${1:app}\n  template:\n    metadata:\n      labels:\n        app: ${1:app}\n    spec:\n      containers:\n      - name: ${1:app}\n        image: ${2:nginx:latest}\n${0}",
    rs      = "apiVersion: apps/v1\nkind: ReplicaSet\nmetadata:\n  name: ${1:app}\nspec:\n  replicas: ${2:1}\n  selector:\n    matchLabels:\n      app: ${1:app}\n  template:\n    metadata:\n      labels:\n        app: ${1:app}\n    spec:\n      containers:\n      - name: ${1:app}\n        image: ${3:nginx:latest}\n${0}",
    pod     = "apiVersion: v1\nkind: Pod\nmetadata:\n  name: ${1:app}\n  labels:\n    app: ${1:app}\nspec:\n  containers:\n  - name: ${1:app}\n    image: ${2:nginx:latest}\n    ports:\n    - containerPort: ${3:80}\n${0}",
    job     = "apiVersion: batch/v1\nkind: Job\nmetadata:\n  name: ${1:job}\nspec:\n  template:\n    spec:\n      containers:\n      - name: ${1:job}\n        image: ${2:busybox}\n        command: ${3:[\"echo\", \"hello\"]}\n      restartPolicy: ${4:Never}\n  backoffLimit: ${5:4}\n${0}",
    cj      = "apiVersion: batch/v1\nkind: CronJob\nmetadata:\n  name: ${1:cronjob}\nspec:\n  schedule: \"${2:0 * * * *}\"\n  jobTemplate:\n    spec:\n      template:\n        spec:\n          containers:\n          - name: ${1:cronjob}\n            image: ${3:busybox}\n            command: ${4:[\"echo\", \"hello\"]}\n          restartPolicy: ${5:OnFailure}\n${0}",
    -- Networking
    svc     = "apiVersion: v1\nkind: Service\nmetadata:\n  name: ${1:app}\nspec:\n  selector:\n    app: ${1:app}\n  ports:\n  - port: ${2:80}\n    targetPort: ${3:80}\n  type: ${4:ClusterIP}\n${0}",
    ing     = "apiVersion: networking.k8s.io/v1\nkind: Ingress\nmetadata:\n  name: ${1:app}\nspec:\n  rules:\n  - host: ${2:app.example.com}\n    http:\n      paths:\n      - path: /\n        pathType: Prefix\n        backend:\n          service:\n            name: ${1:app}\n            port:\n              number: ${3:80}\n${0}",
    netpol  = "apiVersion: networking.k8s.io/v1\nkind: NetworkPolicy\nmetadata:\n  name: ${1:app}\nspec:\n  podSelector:\n    matchLabels:\n      app: ${1:app}\n  policyTypes:\n  - Ingress\n  - Egress\n  ingress:\n  - from:\n    - podSelector:\n        matchLabels:\n          app: ${2:allowed}\n    ports:\n    - port: ${3:80}\n${0}",
    -- Config & Storage
    cm      = "apiVersion: v1\nkind: ConfigMap\nmetadata:\n  name: ${1:app}\ndata:\n  ${2:key}: ${3:value}\n${0}",
    secret  = "apiVersion: v1\nkind: Secret\nmetadata:\n  name: ${1:app}\ntype: Opaque\ndata:\n  ${2:key}: ${3:base64value}\n${0}",
    pvc     = "apiVersion: v1\nkind: PersistentVolumeClaim\nmetadata:\n  name: ${1:app}\nspec:\n  accessModes:\n  - ${2:ReadWriteOnce}\n  resources:\n    requests:\n      storage: ${3:1Gi}\n${0}",
    pv      = "apiVersion: v1\nkind: PersistentVolume\nmetadata:\n  name: ${1:pv}\nspec:\n  capacity:\n    storage: ${2:1Gi}\n  accessModes:\n  - ${3:ReadWriteOnce}\n  persistentVolumeReclaimPolicy: ${4:Retain}\n  storageClassName: ${5:manual}\n  hostPath:\n    path: ${6:/mnt/data}\n${0}",
    sc      = "apiVersion: storage.k8s.io/v1\nkind: StorageClass\nmetadata:\n  name: ${1:standard}\nprovisioner: ${2:kubernetes.io/no-provisioner}\nvolumeBindingMode: ${3:WaitForFirstConsumer}\n${0}",
    -- RBAC
    role    = "apiVersion: rbac.authorization.k8s.io/v1\nkind: Role\nmetadata:\n  name: ${1:role}\n  namespace: ${2:default}\nrules:\n- apiGroups: [\"${3:}\"]\n  resources: [\"${4:pods}\"]\n  verbs: [\"${5:get}\", \"${6:list}\", \"${7:watch}\"]\n${0}",
    crole   = "apiVersion: rbac.authorization.k8s.io/v1\nkind: ClusterRole\nmetadata:\n  name: ${1:role}\nrules:\n- apiGroups: [\"${2:}\"]\n  resources: [\"${3:pods}\"]\n  verbs: [\"${4:get}\", \"${5:list}\", \"${6:watch}\"]\n${0}",
    rb      = "apiVersion: rbac.authorization.k8s.io/v1\nkind: RoleBinding\nmetadata:\n  name: ${1:binding}\n  namespace: ${2:default}\nsubjects:\n- kind: ${3:ServiceAccount}\n  name: ${4:app}\n  namespace: ${2:default}\nroleRef:\n  kind: Role\n  name: ${5:role}\n  apiGroup: rbac.authorization.k8s.io\n${0}",
    crb     = "apiVersion: rbac.authorization.k8s.io/v1\nkind: ClusterRoleBinding\nmetadata:\n  name: ${1:binding}\nsubjects:\n- kind: ${2:ServiceAccount}\n  name: ${3:app}\n  namespace: ${4:default}\nroleRef:\n  kind: ClusterRole\n  name: ${5:role}\n  apiGroup: rbac.authorization.k8s.io\n${0}",
    -- Scaling & Policy
    hpa     = "apiVersion: autoscaling/v2\nkind: HorizontalPodAutoscaler\nmetadata:\n  name: ${1:app}\nspec:\n  scaleTargetRef:\n    apiVersion: apps/v1\n    kind: Deployment\n    name: ${1:app}\n  minReplicas: ${2:1}\n  maxReplicas: ${3:10}\n  metrics:\n  - type: Resource\n    resource:\n      name: cpu\n      target:\n        type: Utilization\n        averageUtilization: ${4:50}\n${0}",
    pdb     = "apiVersion: policy/v1\nkind: PodDisruptionBudget\nmetadata:\n  name: ${1:app}\nspec:\n  minAvailable: ${2:1}\n  selector:\n    matchLabels:\n      app: ${1:app}\n${0}",
    -- Other
    ns      = "apiVersion: v1\nkind: Namespace\nmetadata:\n  name: ${1:namespace}\n${0}",
    sa      = "apiVersion: v1\nkind: ServiceAccount\nmetadata:\n  name: ${1:app}\n  namespace: ${2:default}\n${0}",
    crd     = "apiVersion: apiextensions.k8s.io/v1\nkind: CustomResourceDefinition\nmetadata:\n  name: ${1:myresource.example.com}\nspec:\n  group: ${2:example.com}\n  versions:\n  - name: v1\n    served: true\n    storage: true\n    schema:\n      openAPIV3Schema:\n        type: object\n        properties:\n          spec:\n            type: object\n  scope: ${3:Namespaced}\n  names:\n    plural: ${4:myresources}\n    singular: ${5:myresource}\n    kind: ${6:MyResource}\n${0}",
    rq      = "apiVersion: v1\nkind: ResourceQuota\nmetadata:\n  name: ${1:quota}\n  namespace: ${2:default}\nspec:\n  hard:\n    requests.cpu: \"${3:1}\"\n    requests.memory: ${4:1Gi}\n    limits.cpu: \"${5:2}\"\n    limits.memory: ${6:2Gi}\n${0}",
    lr      = "apiVersion: v1\nkind: LimitRange\nmetadata:\n  name: ${1:limits}\n  namespace: ${2:default}\nspec:\n  limits:\n  - type: Container\n    default:\n      cpu: ${3:500m}\n      memory: ${4:256Mi}\n    defaultRequest:\n      cpu: ${5:250m}\n      memory: ${6:128Mi}\n${0}",
  },
  python = {
    func    = "def ${1:name}(${2:args}):\n\t${0}",
    cls     = "class ${1:Name}:\n\tdef __init__(self${2:, args}):\n\t\t${0}",
    main    = 'if __name__ == "__main__":\n\t${0}',
    forr    = "for ${1:item} in ${2:iterable}:\n\t${0}",
    trye    = "try:\n\t${1}\nexcept ${2:Exception} as e:\n\t${0}",
  },
}

-- completefunc signature: (findstart, base) -> col | list
_G.SnippetComplete = function(findstart, base)
  if findstart == 1 then
    local col = vim.fn.col(".") - 1
    local line = vim.fn.getline(".")
    while col > 0 and line:sub(col, col):match("[%w_]") do
      col = col - 1
    end
    return col
  end

  local ft = vim.bo.filetype
  local ft_snippets = snippets[ft]
  if not ft_snippets then return {} end

  local items = {}
  for trigger, _ in pairs(ft_snippets) do
    if trigger:sub(1, #base) == base then
      table.insert(items, {
        word  = trigger,
        kind  = "S",
        menu  = "[snippet]",
        dup   = 1,
      })
    end
  end
  table.sort(items, function(a, b) return a.word < b.word end)
  return items
end

-- On CompleteDone, if a snippet item was chosen, expand it
vim.api.nvim_create_autocmd("CompleteDone", {
  callback = function()
    local item = vim.v.completed_item
    if not item or item.menu ~= "[snippet]" then return end

    local ft = vim.bo.filetype
    local ft_snippets = snippets[ft]
    if not ft_snippets then return end

    local body = ft_snippets[item.word]
    if not body then return end

    -- Remove inserted word then expand
    local row = vim.fn.line(".") - 1
    local col = vim.fn.col(".") - 1
    vim.api.nvim_buf_set_text(0, row, col - #item.word, row, col, {})
    vim.snippet.expand(body)
  end,
})

-- Enable snippet completefunc for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(snippets),
  callback = function()
    -- "Fv:lua.SnippetComplete" adds our snippets as a completion source
    vim.opt_local.complete:append("Fv:lua.SnippetComplete")
  end,
})
