
class Keys {

  final String? keys;

   Keys(
        {
        required this.keys,
    
});


factory Keys.fromRTDB(Map<String, dynamic> data )
{
  return Keys(
    keys : data['keys'],
    
    );
}
  
}