using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using System;

public class ScoreManager : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField] private TextMeshProUGUI gameScoreText;
    [SerializeField] private float muiltipler;
    
    void Awake()
    {
        MergeManager.onMergeItems += onMergeItemsCallback;
    }

    void OnDestroy()
    {
        MergeManager.onMergeItems -= onMergeItemsCallback;
    
    }

    private int score;
    void Start()
    {
         UpdateScoreText();
    }

    private void onMergeItemsCallback(ItemType itemType, Vector2 position)
    {
        int scoreToAdd = (int)itemType * (int)muiltipler;
        score += scoreToAdd;
        UpdateScoreText();

    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void UpdateScoreText( )
    {
        gameScoreText.text = score.ToString();

    }

    public void RecieveScoreMultiplier(String scoreMultiplier)
    {
        muiltipler = float.Parse(scoreMultiplier);
    }
}
