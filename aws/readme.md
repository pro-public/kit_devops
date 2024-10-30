# Last update 03-10-2024
# Disclaimer : Usar bajo su propia responsabilidad.
# 
# pip install boto3

Asegúrate de tener tus credenciales de AWS configuradas en tu entorno (~/.aws/credentials) o configuradas como variables de entorno (AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY).

Notas Importantes:
Seguridad: Antes de ejecutar cualquier script, asegúrate de tener un respaldo de tus recursos, ya que la eliminación es irreversible.
Permisos: Verifica que la cuenta de AWS con la que se ejecuta el script tenga permisos de eliminación (Delete y Terminate) para todos los recursos que se desean eliminar.
Recursos Default: Si hay recursos predeterminados que no deben eliminarse, añade una verificación adicional en el script para evitar su eliminación. Por ejemplo, algunas VPC predeterminadas o buckets específicos de AWS (p. ej., aws-cloudtrail-logs).