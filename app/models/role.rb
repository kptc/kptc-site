class Role
  
  def self.all
    {
      'A' => 'Admin',
      'U' => 'User',
      'L' => 'Limited'
    }
    
    # more descriptive way,
    # but requires iterating over the array to find the right code
    # [
    #   {code: 'A', name: 'Admin'},
    # ]
  end
  
end